export interface MenuItem {
    itemId: string;
    category: string;
    name: string;
    cost: number;
}

export interface UpdateMenuItem {
    category: string;
    name: string;
    cost: number;
}