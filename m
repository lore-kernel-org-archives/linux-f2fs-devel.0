From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH v4 1/3] f2fs: introduce
 F2FS_FEATURE_LOST_FOUND feature
Date: Fri, 9 Mar 2018 20:31:47 +0800
Message-ID: <3b87131c-7c8e-0904-f46c-36de2b3d4d3d@kernel.org>
References: <20180309075312.62357-1-shengyong1@huawei.com>
 <20180309075312.62357-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1euHCA-00061x-Kn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 12:32:22 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euHC8-00B4Lo-Nl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 12:32:22 +0000
In-Reply-To: <20180309075312.62357-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, ebiggers@google.com, tytso@mit.edu
Cc: linux-fscrypt@vger.kernel.org, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/9 15:53, Sheng Yong wrote:
> This patch introduces a new feature, F2FS_FEATURE_LOST_FOUND, which
> is set by mkfs. mkfs creates a directory named lost+found, which saves
> unreachable files. If fsck finds a file which has no parent, or its
> parent is removed by fsck, the file will be placed under lost+found
> directory by fsck.
> 
> lost+found directory could not be encrypted. As a result, the root
> directory cannot be encrypted too. So if LOST_FOUND feature is enabled,
> let's avoid to encrypt root directory.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
