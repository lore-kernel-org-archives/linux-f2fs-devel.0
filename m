From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC][PATCH v5 06/09] f2fs: use common file type
 conversion
Date: Wed, 23 Jan 2019 14:27:34 +0800
Message-ID: <6f759f75-5906-e499-e86b-a915d714e8c4@huawei.com>
References: <20190121005434.GA32358@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gmC0q-0001w6-33
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 06:27:48 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gmC0n-007Ywe-G3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 06:27:48 +0000
In-Reply-To: <20190121005434.GA32358@pathfinder>
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
To: Phillip Potter <phil@philpotter.co.uk>, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, viro@zeniv.linux.org.uk, linux-f2fs-devel@lists.sourceforge.net

On 2019/1/21 8:54, Phillip Potter wrote:
> Deduplicate the f2fs file type conversion implementation and remove
> F2FS_FT_* definitions - file systems that use the same file types
> as defined by POSIX do not need to define their own versions and can
> use the common helper functions decared in fs_types.h and implemented
> in fs_types.c
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
