From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/5] f2fs: update start nid only once each
	circle
Date: Sat, 08 Mar 2014 19:46:35 +0800
Message-ID: <001301cf3ac4$3220b8c0$96622a40$@samsung.com>
References: <5319A2CC.3090206@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WMFjE-0000oD-4w
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 11:47:44 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WMFjB-00085s-SW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 11:47:44 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N24007DW8RAYV50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 20:47:34 +0900 (KST)
In-reply-to: <5319A2CC.3090206@cn.fujitsu.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'Kim' <jaegeuk.kim@samsung.com>
Cc: 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

Hi Gu,

> -----Original Message-----
> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> Sent: Friday, March 07, 2014 6:43 PM
> To: Kim
> Cc: linux-kernel; f2fs
> Subject: [f2fs-dev] [PATCH 1/5] f2fs: update start nid only once each circle
> 
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/node.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 8c14110..9653096 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1875,11 +1875,15 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>  	while ((found = __gang_lookup_nat_cache(nm_i,
>  					nid, NATVEC_SIZE, natvec))) {
>  		unsigned idx;
> +
> +		nid = nat_get_nid(natvec[found - 1]) + 1;
> +
>  		for (idx = 0; idx < found; idx++) {
>  			struct nat_entry *e = natvec[idx];

Could we replace argument 'e' with 'natvec[idx]'? then we could remove 'e' and
brace here.

Thanks.

> -			nid = nat_get_nid(e) + 1;
> +
>  			__del_from_nat_cache(nm_i, e);
>  		}
> +
>  	}
>  	f2fs_bug_on(nm_i->nat_cnt);
>  	write_unlock(&nm_i->nat_tree_lock);
> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
> With Perforce, you get hassle-free workflows. Merge that actually works.
> Faster operations. Version large binaries.  Built-in WAN optimization and the
> freedom to use Git, Perforce or both. Make the move to Perforce.
> http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
