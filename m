From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: only set project inherit bit for
 directory
Date: Thu, 13 Jun 2019 16:01:44 +0800
Message-ID: <fd3c0e10-cfed-d924-5948-eb2a4fd89c63@huawei.com>
References: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbKgJ-0004i1-NB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:01:59 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbKgE-004j41-NZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:01:57 +0000
In-Reply-To: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
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
To: Wang Shilong <wangshilong1991@gmail.com>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Andreas Dilger <adilger@dilger.ca>, Wang Shilong <wshilong@ddn.com>

On 2019/6/13 15:29, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
