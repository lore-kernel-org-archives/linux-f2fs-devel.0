From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH v3 2/2] fsck.f2fs: reconnect unreachable
 files to lost+found
Date: Thu, 8 Mar 2018 14:41:57 +0800
Message-ID: <5f0c2f55-7f45-ceaa-69c8-70d005da900d@huawei.com>
References: <20180306033940.122604-1-shengyong1@huawei.com>
 <20180306033940.122604-3-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1etpGE-001eOY-It
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 06:42:42 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etpG9-003IdV-BV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 06:42:39 +0000
In-Reply-To: <20180306033940.122604-3-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/6 11:39, Sheng Yong wrote:
> This patch introduces lost_found feature to fsck. If a file is found
> unreachable by fsck. Fsck tries to reconnect the file to lost+found
> directory:
>   1. Scan all unreachable file inodes, ignore non-inodes ones and
>      directories.
>   2. Check them and fix incorrupted data to make sure filesystem
>      metadata (mainly counters and main/nat bitmap) are all consistent.
>   3. Reconnect these files to lost+found. If lost+found does not exist,
>      create it first. During reconnecting, expand lost+found's dentry
>      block automatically. Reconnected files are renamed after its ino
>      number.
>   4. If reconnect fails drop the node and restore filesystem metadata.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
