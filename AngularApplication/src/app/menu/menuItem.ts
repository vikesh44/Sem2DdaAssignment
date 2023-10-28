export interface MenuItem {
  itemId: string;
  category: string;
  name: string;
  cost: number;
  isAvailable: boolean;
}

export interface UpdateMenuItem {
  category: string;
  name: string;
  cost: number;
  isAvailable: boolean;
}
