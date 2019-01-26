From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: use xattr_prefix to wrap up
Date: Sat, 26 Jan 2019 10:49:53 +0800
Message-ID: <22b1084c-02de-8a57-8d6e-9db894f79cf7@huawei.com>
References: <20190125121139.27858-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gnE2i-0006ec-Ly
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Jan 2019 02:50:00 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gnE2g-00FD0P-Ne
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Jan 2019 02:50:00 +0000
In-Reply-To: <20190125121139.27858-1-gaoxiang25@huawei.com>
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
To: Gao Xiang <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2019/1/25 20:11, Gao Xiang wrote:
> Let's use xattr_prefix instead of open code.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
