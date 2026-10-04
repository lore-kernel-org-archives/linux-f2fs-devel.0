Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D08CCA5FE6
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W9NKit6wfjCqG3ggVnWxtk51Se9GXCSq2hvxSsYcWjw=; b=c4SRLbRO104abA3zMWo+ym4L+J
	YoG1a3ePW2nvfv187yBKnXACkBRciaRTeRVSs9rF6bzvV4YgetE2iSVhN9IguAylw1d1qgXRUU8bz
	zfzMQZGQ454zkIfwu9VpegjLICh13jqSlxMqpMPrPMjZG9f+iTcATayZc7nonjeQOxro=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDHfc-0007vw-Ke;
	Sun, 04 Oct 2026 08:34:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <david.laight.linux@gmail.com>) id 1xDHfb-0007vo-55
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HFDC0D77tUqEmXehAlYyAx2E0DK1wOzX1zKg1ym3bo=; b=SYNfjgHVCVCi/5rs8vfNiWQjZx
 2wbB75Fqkk4AYrVtVk9YmOsJhmM62c0fImR1SqPapQiNVDRVAnSZUPcSs1exSRB0qw4UdgmTwjMnz
 p4Qdf22nTFJg2L8ASixWGkiD+rbrkee+nh2BhmLgsOLANNkw1ZstwiYk02Tzd5v9WGos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0HFDC0D77tUqEmXehAlYyAx2E0DK1wOzX1zKg1ym3bo=; b=SrdpgEjht4SI59iSxYjlyUrKF6
 oqoxWeVVL4oNgGGUmN3LRHlBM+z6mLnimDP2XHEMIHoAvzwPscL2iV46RVuK1MHJm93H3V0wSR6ZO
 m9XGAhi6RlKUO3fF1JncGqU9ZnvoJDajCNbBUq6CBNQ3u/RTpeaygpzvVNTRtXruPW1Q=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDHfa-0003jq-ID for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:34:07 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so478577f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791102840; x=1791707640; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0HFDC0D77tUqEmXehAlYyAx2E0DK1wOzX1zKg1ym3bo=;
 b=KJWOLRccsn23xKJ18+juQqRIJY3DpDaEbGlGsSKCLJdW7GA/dcMWh4rcQ/VB5+z9Ed
 qg3AqPI1VdAXiuZdVzDzSGmqDZV/mKpIxlq4DUG5dnfpYjWOCGWdXUrHsXOBAC7ytQRz
 On+DCbpl5WCv+6lAEtLf1B/H4CTpOVy4KPYAYucJbbPXqpvi+BpsOHEW7OWMEmasvPDX
 is5DU9e04MMvEsaR7fRFZktVSCloakKwKxFmrt6VWcouS49IZQi8HCl80p1tZY12Err5
 UmiYvx2Q9gfiBIZHeFobpZgZ/+qnVoQnXZoFriQJQaFodG/KGZU1q/sGyaSiA43M29PO
 RVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791102840; x=1791707640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0HFDC0D77tUqEmXehAlYyAx2E0DK1wOzX1zKg1ym3bo=;
 b=HDmsklqB+EKGyDtUlytDaQYvBXq+q0h61NojW6QcfZO6fZsQ/w/zgXSYGqax+hmzdw
 5jM5Awf3HaIneU+Svr9igkCkXDWmtdEbocCSdmX7bawi1lDN3QPaqzr1U2UuGWMzP5X8
 XHdjJqFt2PtNOrTl82ROoPxA9vMRjrTM+Fdl+t5qlxNtsx711jJWdxfJ74YXzwi5mwlO
 Cf+O+tvrjEK2XMWBuDpGko5wW1QkVEPbeXTexij6eB5MKOOTzLIsQeyfh9Et2dS5N1va
 Ugb3GPzfisy64Xm48ojU7w7O7cECuDKOPzEH/uAHsG6GXl6SA0ajXeWYLXK2Zqmd0V1t
 8CsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvGDClkHwIgAOUK/JZoKMCxCbKxr8yCxwFaRASdqAhX4gbrvDMrolODruk4UJgsbGs5JZywA63/ZSFM8oueRMP@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI5sxnNRk6dKzJqw50yir6Nj2kMc1cwKVpfoZITkzDVbIOTxpiZ
 SGeift/73u9nBvrXKnE1U5q6hTBAnwY5Qbdtawq8sLUzXQH1d00O/0YE
X-Gm-Gg: AYBFou3oENZq8298aMLyE7xEOfhk5eYRdCJUW9xP8qvVk9P3fW3LwVJWrc8kOAKra8d
 PHNm6Hy0eimzTndJ0m4RgPSnTnKhLud7YZD777rkuZrPcBn33N6f3jqvlfx8zXRppgXQLHgIdzU
 YbIcrXDZVJpnDFJBqYjbeMz0bF/bUVzFvtFHrC/ctrIv/pDLboQjZa/ixX11ffLT+uxSeWiAgP4
 qnfcOwJ0VkjAsEQ9AIeR0cLOHv00ZF0FlrL1FkTBdDl+pdi8Azbe7ClWx6QDJOesixcbJpPAKGF
 IcjVAC2gRrNb2p9GvtE9yzg/7NU2cQqnAKNrFzbnZz1h1TmVXTN7wjKYEX+VtMW/j/y85LxZ3cI
 cgSuRbfLzx8kv8wt2k8kCQ5msvE20gk8SAyAFzxazXnBiLm2/pam1UKZ2cqgnkGYgtfBR3v1UmO
 9hp/jseLblTvsJJKOnwktOAQbKI8Hq2hCGaI+GJObb6eN75N3+lSEe5ZgUQ/hkqNqMESY4uk0Pf
 SunV9EDvC96vyhJzObE7H1HMT8HWsl3IVOFYMUvG7ZAlg==
X-Received: by 2002:a5d:5d0f:0:b0:488:83f7:633a with SMTP id
 ffacd0b85a97d-48b12736b49mr11750202f8f.28.1791102839800; 
 Sun, 04 Oct 2026 01:33:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f04f8sm17350793f8f.9.2026.10.04.01.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:33:59 -0700 (PDT)
Date: Sun, 4 Oct 2026 09:33:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Message-ID: <20261004093357.33a124b4@pumpkin>
In-Reply-To: <fac0f401-bbd3-444b-a755-53cc393673de@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
 <arn3TC7BgjTXWmdG@google.com>
 <fac0f401-bbd3-444b-a755-53cc393673de@samsung.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
X-Headers-End: 1xDHfa-0003jq-ID
Subject: Re: [f2fs-dev] [PATCH RFC 1/9] lib/lz4: import upstream LZ4 sources
 verbatim
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sungguk <sungguk.na@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Yann Collet <yann.collet.73@gmail.com>,
 Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, llvm@lists.linux.dev,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-crypto@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@meta.com>, Borislav Petkov <bp@alien8.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, 4 Oct 2026 01:50:39 +0200
Michal Wilczynski <m.wilczynski@samsung.com> wrote:

> On 9/28/26 07:19, Sergey Senozhatsky wrote:
> > On (26/09/25 13:27), Michal Wilczynski wrote:
> > [..]  
> >> +int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
> >> +{
> >> +    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
> >> +    assert(ctx != NULL);  
> > 
> > Probably in some other places as well:
> > 
> > LZ4_initStream() can return NULL, but the code immediately derefs
> > the pointer.  The assert() check seems to be misplaced, unless I'm
> > missing something.
> > 
> > I suppose those need to be decoupled.  First LZ4_initStream() call and
> > NULL check, then stream->internal_donotuse.  
> 
> Good catch, this assert() is a noop in the kernel (as any build without
> LZ4_DEBUG), so a NULL, undersized or misaligned wrkmem oopses in
> LZ4_compress_fast(), and LZ4_compress_destSize() and LZ4_resetStreamHC()
> carry on with an uninitialised state.

The assert() is also just a waste of code.
Debugging the NULL pointer dereference is just as easy.

David 
 
> 
> No in-tree caller hits it (all use kmalloc/vmalloc), and I listed the
> alignment requirement as a behaviour change in the cover letter. Still,
> the vendored files need to stay verbatim.
> 
> So in v2 our own entry points can check alignment with a WARN_ON_ONCE()
> and bail out early. It might be something that we can fix upstream as
> well.
> 
> 
> >   
> 
> Best regards,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
