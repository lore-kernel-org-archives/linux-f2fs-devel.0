From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 1/5] mkfs.f2fs: introduce mkfs parameters
 in f2fs_configuration
Date: Fri, 9 Feb 2018 11:21:19 +0800
Message-ID: <1176eb0b-1c70-8982-be2f-b453af9ed773@huawei.com>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-2-shengyong1@huawei.com>
 <0cf30d18-1ccf-f09e-2f9a-79e2673cd00b@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ejzFp-0005uO-22
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:21:37 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejzFm-0000qF-Uz
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:21:37 +0000
In-Reply-To: <0cf30d18-1ccf-f09e-2f9a-79e2673cd00b@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, hyojun@google.com
Cc: miaoxie@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

Add Hyojun.

On 2018/2/8 21:30, Chao Yu wrote:
> On 2018/2/6 12:31, Sheng Yong wrote:
>>   	/* only root inode was written before truncating dnodes */
>>   	last_inode_pos = start_inode_pos +
>> -		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + quota_inum;
>> +		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + c.quota_inum;
> 
> - f2fs_create_root_dir
>   - f2fs_write_root_inode
>    - discard_obsolete_dnode
>      access c.quota_inum
>   - f2fs_write_qf_inode
>     update c.quota_inum
> 
> Should c.quota_inum be initialized more early?

I think we should only count quota inodes if thye are already initialized.
Otherwise, if quota_ino is not enabled, there is only one inode (root) in
CURSEG_HOT_NODE, and two blocks next to root inode will not be discarded.

I'm a bit confused about the `offset' scale in discard_obsolete_dnode.
It seems `if (offset >= start_inode_pos || offset <= last_inode_pos)'
will always be true?

Hi, Hyojun, could you please also have a look at this, thanks :)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 0fc8b30..6c9ae22 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -963,7 +963,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
                 }
                 offset = next_blkaddr;
                 /* should avoid recursive chain due to stale data */
-               if (offset >= start_inode_pos || offset <= last_inode_pos)
+               if (offset <= last_inode_pos)
                         break;
         } while (1);

thanks,
Sheng
> 
> Thanks,
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
