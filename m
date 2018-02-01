From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: use crc ^ cp_ver instead of crc |
 cp_ver for recovery
Date: Thu, 1 Feb 2018 22:30:51 +0800
Message-ID: <7f5db76f-65e1-6132-4810-0ceb1ce379d6@kernel.org>
References: <9047C53C18267742AB12E43B65C7F9F70BCE5C21@dggemi505-mbx.china.huawei.com>
 <c3444561-9c65-97ce-4bf6-c7f16270d96a@kernel.org>
 <d93d629f-f24c-2e8d-51c0-5c7860d517c2@huawei.com>
 <b4337b94-3f9c-9e18-3fff-76d230db576c@huawei.com>
 <84228ad0-b71c-dc49-5326-80e98d15ddd1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ehFtS-0006UE-K7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 14:31:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehFtR-0000fs-V9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 14:31:14 +0000
In-Reply-To: <84228ad0-b71c-dc49-5326-80e98d15ddd1@kernel.org>
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
To: Gao Xiang <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gao Xiang <hsiangkao@aol.com>, heyunlei <heyunlei@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

> We can use this calculation since cp_ver is complete 64-bits random number now.

Sorry, I meant we can't.

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
