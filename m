From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: use cur_map instead of ckpt_map
Date: Tue, 10 Apr 2018 14:37:58 +0800
Message-ID: <98db5610-1049-fff4-b6f6-dfc48d6d3a28@huawei.com>
References: <1523328631-6658-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5mv4-0007qM-Ls
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 06:38:18 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5mv2-001MWP-Jv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 06:38:18 +0000
In-Reply-To: <1523328631-6658-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/10 10:50, Yunlei He wrote:
> In flush_sit_entries::add_discard_addrs path, cur_map and ckpt_map
> are the same, but in exist_trim_candidates::add_discard_addrs,
> cur_map is updated one, and newer than ckpt_map, so we need to use
> cur_map to check whether there are discard candidates.
> 
> v1->v2: one problem of check discard candidates reported by Chao,
> besides, update commit message.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
