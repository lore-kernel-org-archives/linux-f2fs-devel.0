Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF8D17120
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:57:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t2weQ-0000Mc-Fl;
	Mon, 21 Oct 2024 17:57:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1t2weD-0000La-Qz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 17:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=35DwyUNuxg0gqkdcJJCZqsB1ixcCDL22oUqwrmbOulI=; b=ar4bT3uP5X+5xC9VqvOFVA9xog
 lBqMTPceq1CYouoJmMH0l/sFssIBpmoVh2jgwQAd+047poW9Mwdb5seBavOwvyH2s1txxE/4IF1jH
 w1O8PzJTi5WFMyvKnB/GAZNr3r0RXTgBv/H7GSaD+Wn63Ujc8BZ2Nn+8Yv0MweTYoGrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=35DwyUNuxg0gqkdcJJCZqsB1ixcCDL22oUqwrmbOulI=; b=J6acU4gvCwLzpW1ZSASU9AVDFh
 obFnZwdLWLrDgtr21AWrwmdD7+cncVK6lSjcy1GEVvYryihnBS3n6psSYH/xZk3sN/Y6QlRk4uWPm
 fxjkiQSujChThuWp9dtAOl6V5odBL3NhWG1c5u2nR4KiyzUwkTRFVg7HExFe2EwHwvQE=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t2weD-00048x-6L for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 17:56:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5C0DCA4375B;
 Mon, 21 Oct 2024 17:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F2FC4CEC7;
 Mon, 21 Oct 2024 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729533402;
 bh=iOp6UPk7kp6624trt50V9GCSl7TCmUx91AXnl52vexs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sJQY/rj4pTIO5uEWlo1heoszsTNmf9jrwjFBD0lIbKoaTFxHVpdjurFhvf6qbFqVx
 3p4d5v2zCCp/LbxdIlTGmC11dWGlMVeXXfBDk8A9Aml+/MAtk2IETKhnM8m6cKxkey
 BZF/dYUet13hmxhgQOUCWlo2mvzJlbvIRi1nLRTDg+g177wJbtfgI05mwIy3+AOG+C
 2RdO3YmkeY7RM1WJnyPqFT2fPe/8kLv+1aQd4pfj1zTvRhlxt250RD3qNZbbCGpcse
 fs5+AtO+kgnLwq3Dm+Zt8UDEsdLr8Tbrkjy5WAyah1cfbA8sbkBGsmyodZGLNuMspU
 cTEE/rSNQw61A==
Date: Mon, 21 Oct 2024 17:56:40 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Message-ID: <20241021175640.GA1370449@google.com>
References: <20241021002935.325878-1-ebiggers@kernel.org>
 <20241021002935.325878-8-ebiggers@kernel.org>
 <20241021104007.6950-E-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241021104007.6950-E-hca@linux.ibm.com>
X-Headers-End: 1t2weD-00048x-6L
Subject: Re: [f2fs-dev] [PATCH 07/15] s390/crc32: expose CRC32 functions
 through lib
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Hendrik Brueckner <brueckner@linux.ibm.com>, linux-mips@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-ext4@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 21, 2024 at 12:40:07PM +0200, Heiko Carstens wrote:
> What makes sure that all of the code is available automatically if the
> CPU supports the instructions like before? I can see that all CRC32
> related config options support also module build options.
> 
> Before this patch, this module and hence the fast crc32 variants were
> loaded automatically when required CPU features were present.
> Right now I don't how this is happening with this series.

There's just a direct symbol dependency now.  For example
ext4.ko -> crc32-s390.ko [crc32c_le_arch] -> crc32.ko [crc32c_le_base].
So, crc32-$arch.ko always gets loaded when there is a user of one of the CRC32
library functions, provided that it was enabled in the kconfig.

crc32-$arch then calls either the accelerated code or the base code depending on
the CPU features.  On most architectures including s390, I made this use a
static branch, so there is almost no overhead (much less overhead than the
indirect call that was needed before).

This is the same way that some of the crypto library code already works.

> > +static int __init crc32_s390_init(void)
> > +{
> > +	if (cpu_have_feature(S390_CPU_FEATURE_VXRS))
> > +		static_branch_enable(&have_vxrs);
> > +	return 0;
> > +}
> > +arch_initcall(crc32_s390_init);
> 
> I guess this should be changed to:
> 
> module_cpu_feature_match(S390_CPU_FEATURE_VXRS, ...);
> 
> Which would make at least the library functions available if cpu
> features are present. But this looks only like a partial solution of
> the above described problem.
> 
> But maybe I'm missing something.

This is not needed, as per the above.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
