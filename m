From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] resize.f2fs: fix max_nat_bitmap_size
 miscalculatation
Date: Tue, 2 Jan 2018 14:32:59 +0800
Message-ID: <63f1be4c-990a-b1b9-2998-978796b238c4@huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCB8BD4@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70BCB8BD4@dggemi505-mbs.china.huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Gaoxiang (OS)" <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Duwei (Device OS)" <weidu.du@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/22 12:20, Gaoxiang (OS) wrote:
> For the same reason as "mkfs.f2fs: fix to calculate
> left space of checkpoint page correctly",
> this patch also fixes miscalculatation in resize.f2fs.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
