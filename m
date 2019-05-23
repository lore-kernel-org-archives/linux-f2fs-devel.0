From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: Fix up nat journal corruption
 with -a (auto-fix) option
Date: Thu, 23 May 2019 22:10:33 +0800
Message-ID: <0608274b-b532-0210-098f-cb59f815c3cd@kernel.org>
References: <1558586627-19784-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1hToQm-0008Ed-MV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 14:10:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hToQl-002nHL-JS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 14:10:52 +0000
In-Reply-To: <1558586627-19784-1-git-send-email-stummala@codeaurora.org>
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
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

On 2019-5-23 12:43, Sahitya Tummala wrote:
> Build segment manager and node manager always to catch and auto-fix
> invalid NAT entries found in the NAT journal.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
