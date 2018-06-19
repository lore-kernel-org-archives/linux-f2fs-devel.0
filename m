From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: calculate inode checksum and
 writeback
Date: Tue, 19 Jun 2018 20:59:35 +0800
Message-ID: <503f7a07-1472-e736-1faa-4c7adba59473@huawei.com>
References: <1528945822-85289-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVGF9-00018T-RD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 13:00:19 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVGF4-002Tln-Mf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 13:00:19 +0000
In-Reply-To: <1528945822-85289-1-git-send-email-liuxueliu.liu@huawei.com>
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
To: Liu Xue <liuxueliu.liu@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/6/14 11:10, Liu Xue wrote:
> Calculate inode checksum and writeback when processing
> sload or resize.
> 
> Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>

Thanks for the fix.

I just look around dev_write_block caller, it looks there are more similar
issues should be fixed.

Could you double check that?

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
