From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: change le32 to le16 of
 f2fs_inode->i_extra_size
Date: Fri, 13 Apr 2018 17:27:16 +0800
Message-ID: <6612631b-6c2c-1b97-0f85-b5bccd97813e@huawei.com>
References: <1523638954-17272-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f6v08-0002tM-Tl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 09:28:12 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6uzt-00AnAY-0q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 09:28:12 +0000
In-Reply-To: <1523638954-17272-1-git-send-email-zhangzhikang1@huawei.com>
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
To: Zhikang Zhang <zhangzhikang1@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/4/14 1:02, Zhikang Zhang wrote:
> In the structure of f2fs_inode, i_extra_size's type is __le16,
> so we should keep type consistent when using it.

Good catch!

Needs to add:

Fixes: 704956ecf5bc ("f2fs: support inode checksum")

> 
> Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
