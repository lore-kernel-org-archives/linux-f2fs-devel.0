From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs-tools: Fix device zoned model
 detection
Date: Mon, 22 Apr 2019 10:41:33 +0800
Message-ID: <94c34aa4-1bc7-0e72-f37f-c5cfbf37401a@huawei.com>
References: <20190422020424.6228-1-shinichiro.kawasaki@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hIOts-0006UZ-0o
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 02:41:44 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIOtq-005EJl-Kc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 02:41:43 +0000
In-Reply-To: <20190422020424.6228-1-shinichiro.kawasaki@wdc.com>
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
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>

On 2019/4/22 10:04, Shin'ichiro Kawasaki wrote:
> A partition device does not have the "zoned" nor "chunk_sectors" sysfs
> attribute files. Only the owner block device of the partition has these
> files. This causes the detection of the zoned model and zone size of a
> partition device to fail when executing mkfs.f2fs.
> 
> Fix this problem by using the owner device sysfs directory as the base
> directory for accessing the zoned and chunk_sectors files. This is done
> by using the device major:minor symbolic link under the /sys/dev/block
> directory, reading this link and removing the partition device name from
> the link path for a partition device (which is indicated by the presence
> of the "partition" file under the directory).
> 
> Also add a check for the ENOENT error when opening the device "zoned"
> sysfs attribute file. The absence of this file indicates that the
> kernel does not support zoned block devices. Since the device file is
> already open, it exists, and so the device can safely be assumed as not
> being zoned.
> 
> Changes from v2:
> * Addressed Chao Yu's comment on snprintf buffer length
> 
> Changes from v1:
> * Addressed Chao Yu's comment on ENOENT and return value checks
> * Rewrite of sysfs file handling (simplified)
> * Rebased on dev-test tree
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

It looks good to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
