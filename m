From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs-tools: create sparse file first
 before stat
Date: Sat, 17 Nov 2018 10:32:49 +0800
Message-ID: <ee5a0f22-b203-2c18-f060-e6cc927d633a@kernel.org>
References: <20181116060603.51965-1-jaegeuk@kernel.org>
 <20181116060603.51965-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gNqPz-0007an-4F
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Nov 2018 02:33:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gNqPx-00BaLL-SL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Nov 2018 02:33:07 +0000
In-Reply-To: <20181116060603.51965-2-jaegeuk@kernel.org>
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

On 2018-11-16 14:06, Jaegeuk Kim wrote:
> We must create a sparse file first before calling stat().
> 
> Fixes: eb9d8037ed3b ("f2fs-tools: avoid mounting f2fs if tools already open the device")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
