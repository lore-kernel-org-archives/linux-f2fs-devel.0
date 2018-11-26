From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] f2fs: fix to update new block address correctly for
 OPU
Date: Mon, 26 Nov 2018 11:35:17 +0100
Message-ID: <20181126103517.GA26941@kroah.com>
References: <20181126183232.51715-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126183232.51715-1-zhujia13@huawei.com>
Sender: stable-owner@vger.kernel.org
To: Jia Zhu <zhujia13@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, jaizhu.zj@gmail.com, shengyong1@huawei.com, yunlong.song@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Nov 27, 2018 at 02:32:32AM +0800, Jia Zhu wrote:
> Previously, we allocated a new block address for OPU mode in direct_IO.
> 
> But the new address couldn't be assigned to @map->m_pblk correctly.
> 
> This patch fix it.
> 
> Fixes: 511f52d02f05 ('f2fs: allow out-place-update for direct IO in LFS mode')
> 
> Signed-off-by: Jia Zhu <zhujia13@huawei.com>
> ---
> v2:
> - update commit message.
> 
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
