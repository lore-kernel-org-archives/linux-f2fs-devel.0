From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix return value of
 f2fs_set_qf_name and parse_options
Date: Mon, 13 Aug 2018 14:30:00 +0800
Message-ID: <b564e37f-7aee-2c3a-d02a-113a0d14eec5@huawei.com>
References: <46a8a2e0.4e2d.16531cdc4a5.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fp6Mk-0001GP-T5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 06:30:10 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fp6Mj-001Zw1-8K
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 06:30:10 +0000
In-Reply-To: <46a8a2e0.4e2d.16531cdc4a5.Coremail.kernelpatch@126.com>
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
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/8/13 13:41, Tiezhu Yang wrote:
> match_strdup() returns NULL when kmalloc failed, so the caller
> function f2fs_set_qf_name() should return -ENOMEM in this case;
> match_int() returns -ENOMEM, -EINVAL, or -ERANGE on failure,
> so the caller function parse_options() should not always return
> -EINVAL in this case.
> 
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
