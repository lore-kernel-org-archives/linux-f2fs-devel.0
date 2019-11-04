Return-Path: <SRS0=dX2f=Y4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05489CA9ECF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88CD21744
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nNo2gH+2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="O4xpQiDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88CD21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iRXKx-0006WV-Cl; Mon, 04 Nov 2019 08:03:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iRXKw-0006V5-8Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Nov 2019 08:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yVuzqg6rD3JFZ/20A8oiUdOzETWc45osF5qd591M4Rc=; b=nNo2gH+2tfV2PwgqtMyXRp/T0b
 LoID2VdqJcYcDocPRjZTUEq5DwwhNpIlzagyJy1SYdt5uV/M/VxRkqOeLad6tprm0mk9NNU3WOfP4
 6iBPc1wjqv9Zp7AzSdiZ6pcRlQ/g3Ote5n6Vf3gUuTHYVg33opGxJQLfaeD6pRzp5/uk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yVuzqg6rD3JFZ/20A8oiUdOzETWc45osF5qd591M4Rc=; b=O4xpQiDaGmBIvD+uOwDPWs4UZ/
 t3HhEXoljFNdTNUUmoXe3xQoTQbXtGpq+BXfWJ9eSk6z0F5Ia55i8rW4REj6PzktXlxZH9m1/O9UC
 5nDKszVVkpAHLXjNzw+KklXsj8ZCfIRxz+I5EVslRfylDjiNLMny0xoc8kcOgn4wLD8g=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iRXKu-00Gu5h-0L
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Nov 2019 08:03:41 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 69F5219BFFA34341D38C;
 Mon,  4 Nov 2019 16:03:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 16:03:28 +0800
To: kbuild test robot <lkp@intel.com>
References: <20191101095324.9902-3-yuchao0@huawei.com>
 <201911022233.zTMqGPBr%lkp@intel.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <28541e80-9f5e-44a0-7590-d95f9f398663@huawei.com>
Date: Mon, 4 Nov 2019 16:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201911022233.zTMqGPBr%lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iRXKu-00Gu5h-0L
Subject: Re: [f2fs-dev] [PATCH 3/3] Revert "f2fs: use kvmalloc,
 if kmalloc is failed"
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

Thanks for the report, I've fixed this.

Thanks,

On 2019/11/2 22:17, kbuild test robot wrote:
> Hi Chao,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on f2fs/dev-test]
> [cannot apply to v5.4-rc5 next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-clean-up-check-condition-for-writting-beyond-EOF/20191102-212408
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/f2fs/super.c: In function 'destroy_device_list':
>>> fs/f2fs/super.c:1055:17: error: 'struct f2fs_dev_info' has no member named 'blkz_type'; did you mean 'blkz_seq'?
>       kfree(FDEV(i).blkz_type);
>                     ^~~~~~~~~
>                     blkz_seq
> 
> vim +1055 fs/f2fs/super.c
> 
>   1047	
>   1048	static void destroy_device_list(struct f2fs_sb_info *sbi)
>   1049	{
>   1050		int i;
>   1051	
>   1052		for (i = 0; i < sbi->s_ndevs; i++) {
>   1053			blkdev_put(FDEV(i).bdev, FMODE_EXCL);
>   1054	#ifdef CONFIG_BLK_DEV_ZONED
>> 1055			kfree(FDEV(i).blkz_type);
>   1056	#endif
>   1057		}
>   1058		kfree(sbi->devs);
>   1059	}
>   1060	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
