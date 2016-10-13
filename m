From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/7] f2fs: rename free nid cache operation
Date: Thu, 13 Oct 2016 18:26:59 +0800
Message-ID: <729a0d1d-424f-2c4d-7a1c-2ab8a18a18b2@huawei.com>
References: <20161011143136.2107-1-chao@kernel.org>
	<20161011143136.2107-3-chao@kernel.org>
	<20161011171903.GB82199@jaegeuk>
	<f1825a12-726f-4d79-b15b-3614d92d6897@kernel.org>
	<20161012171548.GA98211@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1budF7-0000Xa-Tj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 10:28:05 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1budF2-0001eW-US
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 10:28:05 +0000
In-Reply-To: <20161012171548.GA98211@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/10/13 1:15, Jaegeuk Kim wrote:
> Then, how about this one?
> 
>>From 4f4b48de34ffaf94baa2065bcd5d44566f8d25b9 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 12 Oct 2016 10:09:59 -0700
> Subject: [PATCH] f2fs: clean up free nid list operations
> 
> This patch cleans up to use consistent free nid list ops.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
