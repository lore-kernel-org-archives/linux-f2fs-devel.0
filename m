From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] fsck.f2fs: Fix up nat journal corruption
 with -a (auto-fix) option
Date: Fri, 24 May 2019 16:54:01 +0800
Message-ID: <e6a31bc6-e707-a1be-3fd9-e8c219bfd80d@huawei.com>
References: <1558678187-13145-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hU5xg-0000hK-2L
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:54:00 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hU5xe-00Cuh8-6A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:54:00 +0000
In-Reply-To: <1558678187-13145-1-git-send-email-stummala@codeaurora.org>
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
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2019/5/24 14:09, Sahitya Tummala wrote:
> Build segment manager and node manager always to catch and auto-fix
> invalid NAT entries found in the NAT journal.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
