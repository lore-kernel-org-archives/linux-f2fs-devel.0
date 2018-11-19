From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/7] f2fs: use IS_ENCRYPTED() to check
 encryption status
Date: Mon, 19 Nov 2018 14:24:31 +0800
Message-ID: <6dec5660-46c0-8061-f1a9-618bed182876@huawei.com>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-3-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gOczI-0006rO-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:24:48 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOczD-005zvO-Sr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:24:47 +0000
In-Reply-To: <20181119052324.31456-3-chandan@linux.vnet.ibm.com>
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
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ebiggers@kernel.org, tytso@mit.edu

On 2018/11/19 13:23, Chandan Rajendra wrote:
> This commit removes the f2fs specific f2fs_encrypted_inode() and makes
> use of the generic IS_ENCRYPTED() macro to check for the encryption
> status of an inode.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
