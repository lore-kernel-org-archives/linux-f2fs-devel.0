From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC][PATCH v3 08/10] f2fs: use common file type
 conversion
Date: Mon, 29 Oct 2018 18:35:03 +0800
Message-ID: <d9979cf6-899d-b264-35df-d765e6f0adba@huawei.com>
References: <20181027005342.GA9982@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gH4t9-0006xR-UE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 10:35:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gH4t8-006CxS-FW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 10:35:15 +0000
In-Reply-To: <20181027005342.GA9982@pathfinder>
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

On 2018/10/27 8:53, Phillip Potter wrote:
> Deduplicate the f2fs file type conversion implementation - file systems
> that use the same file types as defined by POSIX do not need to define
> their own versions and can use the common helper functions decared in
> fs_types.h and implemented in fs_types.c
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
