From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH 1/5] mkfs.f2fs: introduce mkfs parameters
 in f2fs_configuration
Date: Thu, 8 Feb 2018 21:30:55 +0800
Message-ID: <0cf30d18-1ccf-f09e-2f9a-79e2673cd00b@kernel.org>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejmIF-0005rl-AC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 13:31:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejmIE-0003yB-LY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 13:31:15 +0000
In-Reply-To: <20180206043125.134191-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/6 12:31, Sheng Yong wrote:
>  	/* only root inode was written before truncating dnodes */
>  	last_inode_pos = start_inode_pos +
> -		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + quota_inum;
> +		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + c.quota_inum;

- f2fs_create_root_dir
 - f2fs_write_root_inode
  - discard_obsolete_dnode
    access c.quota_inum
 - f2fs_write_qf_inode
   update c.quota_inum

Should c.quota_inum be initialized more early?

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
