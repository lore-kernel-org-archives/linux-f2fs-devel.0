From: Chao Yu <chao@kernel.org>
Subject: Re: Bug report: null ptr dereference in
 fscrypt_do_page_crypto() when operating a file on a corrupted f2fs image
Date: Tue, 10 Jul 2018 23:42:30 +0800
Message-ID: <56fa8401-ba1e-3f0e-83cc-4ad0bf821ff7@kernel.org>
References: <15F87A3F-7218-435E-8D5B-2D3BF3434B9E@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fcumt-0000bf-Nq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 15:42:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcums-005F9b-8M
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 15:42:47 +0000
In-Reply-To: <15F87A3F-7218-435E-8D5B-2D3BF3434B9E@gatech.edu>
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
To: "Xu, Wen" <wen.xu@gatech.edu>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Wen,

On 2018/7/10 7:51, Xu, Wen wrote:
> Hi Chao,
> 
> Could you please check: https://bugzilla.kernel.org/show_bug.cgi?id=200465

Added a patch for that. :)

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=bcabbf8812ac9b37ab0b93e8f1fcf6b9fb2d1825

Thanks,

> 
> This new issue cannot be solved by your recent commits from my testing.
> 
> Thanks,
> Wen
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
