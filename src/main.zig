const std = @import("std");

pub const TriangleError = error{
    Invalid,
};

pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        if (a <= 0.0 or b <= 0.0 or c <= 0) return TriangleError.Invalid;
        if (a + b <= c) return TriangleError.Invalid;
        if (b + c <= a) return TriangleError.Invalid;
        if (c + a <= b) return TriangleError.Invalid;
        return Triangle{
            .a = a,
            .b = b,
            .c = c,
        };
    }

    pub fn isEquilateral(self: Triangle) bool {
        if (self.a == self.b and self.b == self.c) return true;
        return false;
    }

    pub fn isIsosceles(self: Triangle) bool {
        if (self.a == self.b or self.a == self.c or self.b == self.c) return true;
        return false;
    }

    pub fn isScalene(self: Triangle) bool {
        if (self.a != self.b and self.a != self.c and self.b != self.c) return true;
        return false;
    }
};

test "equilateral all sides are equal" {
    const actual = try Triangle.init(2, 2, 2);

    try std.testing.expect(actual.isEquilateral());
}

test "equilateral any side is unequal" {
    const actual = try Triangle.init(2, 3, 2);

    try std.testing.expect(!actual.isEquilateral());
}

test "equilateral no sides are equal" {
    const actual = try Triangle.init(5, 4, 6);

    try std.testing.expect(!actual.isEquilateral());
}

test "equilateral all zero sides is not a triangle" {
    const actual = Triangle.init(0, 0, 0);

    try std.testing.expectError(TriangleError.Invalid, actual);
}

test "equilateral sides may be floats" {
    const actual = try Triangle.init(0.5, 0.5, 0.5);

    try std.testing.expect(actual.isEquilateral());
}

test "isosceles last two sides are equal" {
    const actual = try Triangle.init(3, 4, 4);

    try std.testing.expect(actual.isIsosceles());
}

test "isosceles first two sides are equal" {
    const actual = try Triangle.init(4, 4, 3);

    try std.testing.expect(actual.isIsosceles());
}

test "isosceles first and last sides are equal" {
    const actual = try Triangle.init(4, 3, 4);

    try std.testing.expect(actual.isIsosceles());
}

test "equilateral triangles are also isosceles" {
    const actual = try Triangle.init(4, 3, 4);

    try std.testing.expect(actual.isIsosceles());
}

test "isosceles no sides are equal" {
    const actual = try Triangle.init(2, 3, 4);

    try std.testing.expect(!actual.isIsosceles());
}

test "isosceles first triangle inequality violation" {
    const actual = Triangle.init(1, 1, 3);

    try std.testing.expectError(TriangleError.Invalid, actual);
}

test "isosceles second triangle inequality violation" {
    const actual = Triangle.init(1, 3, 1);

    try std.testing.expectError(TriangleError.Invalid, actual);
}

test "isosceles third triangle inequality violation" {
    const actual = Triangle.init(3, 1, 1);

    try std.testing.expectError(TriangleError.Invalid, actual);
}

test "isosceles sides may be floats" {
    const actual = try Triangle.init(0.5, 0.4, 0.5);

    try std.testing.expect(actual.isIsosceles());
}

test "scalene no sides are equal" {
    const actual = try Triangle.init(5, 4, 6);

    try std.testing.expect(actual.isScalene());
}

test "scalene all sides are equal" {
    const actual = try Triangle.init(4, 4, 4);

    try std.testing.expect(!actual.isScalene());
}

test "scalene first and second sides are equal" {
    const actual = try Triangle.init(4, 4, 3);

    try std.testing.expect(!actual.isScalene());
}

test "scalene first and third sides are equal" {
    const actual = try Triangle.init(3, 4, 3);

    try std.testing.expect(!actual.isScalene());
}

test "scalene second and third sides are equal" {
    const actual = try Triangle.init(4, 3, 3);

    try std.testing.expect(!actual.isScalene());
}

test "scalene may not violate triangle inequality" {
    const actual = Triangle.init(7, 3, 2);

    try std.testing.expectError(TriangleError.Invalid, actual);
}

test "scalene sides may be floats" {
    const actual = try Triangle.init(0.5, 0.4, 0.6);

    try std.testing.expect(actual.isScalene());
}
