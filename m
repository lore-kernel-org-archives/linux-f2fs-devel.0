From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: do not hard-code encrypted
 filename length to avoid heap buffer overflow
Date: Mon, 15 Oct 2018 20:09:23 +0800
Message-ID: <5897b733-2b8e-f9d0-9312-2cf3b0f6224a@huawei.com>
References: <20181010004647.21630-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gC1gn-0001zU-MD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 12:09:37 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gC1gm-0020V4-6z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 12:09:37 +0000
In-Reply-To: <20181010004647.21630-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2018/10/10 8:46, Jaegeuk Kim wrote:
> From: Randall Huang <huangrandall@google.com>
> 
> If the len is less than 24, heap buffer overflow is reported.
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
