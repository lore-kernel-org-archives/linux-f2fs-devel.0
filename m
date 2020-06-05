Return-Path: <SRS0=5W2J=7S=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C47C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30982077D;
	Fri,  5 Jun 2020 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="a3y60wFa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="f0rga9CM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="FdIOq36i";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="Yugvd6VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30982077D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSW7u7CGsWAPNiVsx/qFa0JAzNw7RuoK4Aaot1S8+/c=; b=a3y60wFawo8kWyZEBpot0xgrnx
	yj1SjZSfHNhDhl/hAathVZPqQ5U646R+lAbhNQVifEFw5OThPxsbkba4suT0SZaSK+caGX1pKaIXz
	vBb3pUBsCxylxbKA32Zr6aOSmlwgp2OwtAKyQqIs18efKohH42INPWguycQjEhR+8y3s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jhFZ1-0001ab-5K; Fri, 05 Jun 2020 16:51:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ndesaulniers@google.com>) id 1jhFYz-0001aH-N3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 16:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S7xS4af/gOGfuhZ4Zdqv+jXOd8ZOfkOlCILXhBQbbH4=; b=f0rga9CMsCRp9o4i5lOrvIqoMG
 r2BzwekjHTuUo23Ni/O/pHroVGr4uBKHpjxxl/xvBadAoeoGa/7qPr2elDrasN55ttRrj7UzRf1AD
 7n57eoES6mlx+X2y6vGSCrG+5N8VapezVqibSxg28j6Yh69iMkUFie/AsyA8DC4zFBus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S7xS4af/gOGfuhZ4Zdqv+jXOd8ZOfkOlCILXhBQbbH4=; b=FdIOq36iSx1Uhkg8SoxDD8lGnQ
 36r7a2LaZBQwhSBSCNJ4TEYIa2YK4vYlC0SemYOuBPKvbcj4G3VEmeno6dWptwrv7RbqtV+MCod9f
 f/txn4M0AdogcCry624FJjXGGSp1RHTphLfhG5Xn28VVkTxEwHQ7OBCJiUqtZj3j7sU0=;
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jhFYx-00D2Cx-Iy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 16:51:25 +0000
Received: by mail-oi1-f196.google.com with SMTP id i74so8792771oib.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2020 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S7xS4af/gOGfuhZ4Zdqv+jXOd8ZOfkOlCILXhBQbbH4=;
 b=Yugvd6VFXPjkpiHN5oveqk8xjKGXgRlb2WXLC3oVnoOJEK5iNYA61Jqi/3+HVuabVX
 Sos2oCEvPuOEbrVTucQARRcX85pw9HGEVoLQnppd7P3di3CoXK3+crJZyUCQfkEasuDb
 2K5M7vsrazX6tkQWJQEMuhBVq/g4cBX8gkBcWbIBCF7P1n0CZ6s0jNGGWZLCAs9raFq9
 cBzTKDPEVLjpic94FleEZ2swPoJpFUK97DZPScAkvaRXFM8ON9JbC622J3l4H3jw/Hx7
 jWgFpQNu1AvWBvMX98hMFDj0foaFFk0n5SlHaKKJwKyXJKPvQURpfEBfS+yXGH/Vyh2l
 oh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S7xS4af/gOGfuhZ4Zdqv+jXOd8ZOfkOlCILXhBQbbH4=;
 b=HOBpd8d4oSTTK8daj/Rk1U481hak/Sfnch+XkEfCRGIiD2AjG0S9+CetF6zm4yiI6o
 N/aoyr+Muki1rGSjfFvo8W9vsPYhCWLsBp49nLUsM+zJVKucmQskj3sxWcpxwuAl/2HT
 SUlB1d4gbVcJWV+Qz6iEEhjpdch+Qhm0qG9lyg7Avcqad7MuAzLXatjBodCKWaBvP8qw
 /LC8yJAYSrCknNSaT4ZDrIfK1T+VNL7KlRjBVZvlinTEP659PtAzOHOVUVkgVkCaiOij
 PZ1ufH1U0hgc1OsLgqzBb9wBQcjZ8YTs+bL9wiigXrvBnulysSJyBOFeGCM2V+E6hKUd
 IwNw==
X-Gm-Message-State: AOAM532Ei/mLxeSe6RlaHILVe6SdmfzhpDjAmbroWSOGoHH9P/kP0kGa
 8tyGQbCdnF0AMxBFjHxfeq+OfPPkterjaC/OuJD9Ny9Rx8Y=
X-Google-Smtp-Source: ABdhPJxLaDuKBPAgwTMGJOqGVGGpnkZg3nzHRHNEN5wSRBMQ4pq30CHKlAFVcYG/FqAGQaGIYePR5dkIgyxyx9eDj6E=
X-Received: by 2002:a17:90b:949:: with SMTP id
 dw9mr3275416pjb.101.1591375555254; 
 Fri, 05 Jun 2020 09:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <202006051725.63EW72i7%lkp@intel.com>
 <20200605145546.GA227721@google.com>
 <20200605160830.GB1373@sol.localdomain>
In-Reply-To: <20200605160830.GB1373@sol.localdomain>
Date: Fri, 5 Jun 2020 09:45:43 -0700
Message-ID: <CAKwvOdm1Ew1dBVcmxDHtKWp383Dsrxjhaweek=-LDomfKnj7Qg@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jhFYx-00D2Cx-Iy
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
From: Nick Desaulniers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 5, 2020 at 9:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Jun 05, 2020 at 07:55:46AM -0700, Jaegeuk Kim wrote:
> > Eric,
> >
> > Could you PTAL?
> >
> > On 06/05, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> > > head:   adf3d3a53cf13d0998c699ba43d8582c875179e3
> > > commit: adf3d3a53cf13d0998c699ba43d8582c875179e3 [48/48] f2fs: don't return vmalloc() memory from f2fs_kmalloc()
> > > config: powerpc64-randconfig-r011-20200605 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project ac47588bc4ff5927a01ed6fcd269ce86aba52a7c)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install powerpc64 cross compiling tool for clang build
> > >         # apt-get install binutils-powerpc64-linux-gnu
> > >         git checkout adf3d3a53cf13d0998c699ba43d8582c875179e3
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
>
> I don't know what's causing this.  It doesn't look at all related to my commit,
> and I don't see what's using so much stack in f2fs_fill_super().
>
> @kernel test robot: the directions given above don't actually work.
> First I got an error due to powerpc64-linux-gnu-elfedit not existing.
> So I had to build binutils for powerpc64 myself.
>
> Then I still got an error:
>
>         make: *** No rule to make target 'arch/powerpc64/Makefile'.  Stop.

If you have the config, then
$ ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- make CC=clang -j71
If you recompile with CONFIG_DEBUG_INFO, you can get the stack frame
information. I wrote a tool to parse this for these cryptic warnings.
https://github.com/ClangBuiltLinux/frame-larger-than

-- 
Thanks,
~Nick Desaulniers


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
