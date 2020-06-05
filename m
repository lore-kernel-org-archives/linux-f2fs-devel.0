Return-Path: <SRS0=5W2J=7S=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBDC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:08:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C78206DB;
	Fri,  5 Jun 2020 16:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UzJbSPJj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GW4sMwcA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODPBRxfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C78206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jhEtp-0004wP-Ra; Fri, 05 Jun 2020 16:08:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jhEto-0004wI-MD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 16:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eyGrzMCK6Mplay3IhmJwwACbyinlv3U2bvk6NfXFf58=; b=UzJbSPJjFlPMgmWaLttz/jNIIo
 9YH1vmRWM1piT0YyeTTTmaWR70BtyYcy+E3oxICopncGpfs5P4oqDsMRtWZ4yOtRLRYGZyp5qMF59
 dYX477jO3eapj5eu/PXc9C8R2HSq0f5Q0YGiWuPUV8tKD18BPRv5icjUIM4vrE1egHZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eyGrzMCK6Mplay3IhmJwwACbyinlv3U2bvk6NfXFf58=; b=GW4sMwcApihwEGl7+FGZhbHbnv
 NjFh70izEu6uVG1QTT77sDXI3Q5rIQwh0h7shMGYyyNbRMbU6EED3jmYxTFYSsc9qR7vOouGXrkop
 lAEsDcCqBDN7/+mw3m0KDWFwO9SfrQEtERCAPj4OequiiLKx7M8tsmtFV2yEGPoy9/wI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jhEtk-00D0Ud-V1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 16:08:52 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F43E206DB;
 Fri,  5 Jun 2020 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591373311;
 bh=BlsTIcI8P4V6/nC8FXgl8QDPPbbuhQ36J1WU7twKM+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ODPBRxfXzj7gkgd1PNqfkdiTE5NoKjMQKsdREHOK8ljHWN7Z0RpEaUq9WYEkJwebm
 ysGqz5NLY8b5M0jNKSr3giaTppydxO3PnmM0wa4AC6buXPsEIXkbScW441RRBfL/Xj
 gUcEbyn4K7fW5eprVApEMpnq+c9NCOwajRvVzqcY=
Date: Fri, 5 Jun 2020 09:08:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, kernel test robot <lkp@intel.com>,
 clang-built-linux@googlegroups.com, kbuild-all@lists.01.org
Message-ID: <20200605160830.GB1373@sol.localdomain>
References: <202006051725.63EW72i7%lkp@intel.com>
 <20200605145546.GA227721@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200605145546.GA227721@google.com>
X-Headers-End: 1jhEtk-00D0Ud-V1
Subject: Re: [f2fs-dev] [f2fs:dev-test 48/48] fs/f2fs/super.c:3303:12:
 warning: stack frame size of 2064 bytes in function 'f2fs_fill_super'
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 05, 2020 at 07:55:46AM -0700, Jaegeuk Kim wrote:
> Eric,
> 
> Could you PTAL?
> 
> On 06/05, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> > head:   adf3d3a53cf13d0998c699ba43d8582c875179e3
> > commit: adf3d3a53cf13d0998c699ba43d8582c875179e3 [48/48] f2fs: don't return vmalloc() memory from f2fs_kmalloc()
> > config: powerpc64-randconfig-r011-20200605 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project ac47588bc4ff5927a01ed6fcd269ce86aba52a7c)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install powerpc64 cross compiling tool for clang build
> >         # apt-get install binutils-powerpc64-linux-gnu
> >         git checkout adf3d3a53cf13d0998c699ba43d8582c875179e3
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>

I don't know what's causing this.  It doesn't look at all related to my commit,
and I don't see what's using so much stack in f2fs_fill_super().

@kernel test robot: the directions given above don't actually work.
First I got an error due to powerpc64-linux-gnu-elfedit not existing.
So I had to build binutils for powerpc64 myself.

Then I still got an error:

	make: *** No rule to make target 'arch/powerpc64/Makefile'.  Stop.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
