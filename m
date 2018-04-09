From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Date: Mon, 9 Apr 2018 14:48:52 +0200
Message-ID: <20180409124852.GE21835@dhcp22.suse.cz>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Christopher Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon 09-04-18 20:25:06, Chao Yu wrote:
[...]
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index c85cccc2e800..cc63f8c448f0 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -339,10 +339,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  make_now:
>  	if (ino == F2FS_NODE_INO(sbi)) {
>  		inode->i_mapping->a_ops = &f2fs_node_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);

An unrelated question. Why do you make all allocations for the mapping
NOFS automatically? What kind of reclaim recursion problems are you
trying to prevent?
-- 
Michal Hocko
SUSE Labs
