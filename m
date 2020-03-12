Return-Path: <SRS0=Hk9E=45=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A45C10DCE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:11:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FE8206CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="CfAZxhGP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NQanL4vh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KvrlyQAH";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="lLp+JNv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FE8206CD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t10WS9tlVJ3YVHF+FSZs+QmkkHULIqMl87BRv8IOWnE=; b=CfAZxhGPJCC/znrCruWjzz4rMt
	g/53twjUSMvDUTwtBGnzJhgGe7mpYDA0udRc38Z25M4IJMGfTu2ur7hPIK2+qMlopo18855Rq2EON
	Ha1weqF98fmRdGm12+z/n2D/ZHhf7Lhiz445lkQwr5GLgT7XxjbGt+yGXC6iNscjs3LE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jCW3G-0001jY-QB; Thu, 12 Mar 2020 22:11:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1jCW3E-0001jD-Nq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 22:11:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f+nbJgOAkU3OKGNy5HAiFcAe6BZ2/dfnnfHDkezdsLM=; b=NQanL4vhppS1EEfKaoUgZcG914
 TRtFr1L4cmKsQJTPNWS7zuO/GEg90RXLkF2F4GCnAQrtP5U2M7pJMRQzJvPpOrBcAy2lRVNAe2TEu
 xze8pLMpDhoODMrbR5oB9E+oWUVjhraNfdp94bHGOKET+ociEInqo/8ZSeWYRNtthV00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f+nbJgOAkU3OKGNy5HAiFcAe6BZ2/dfnnfHDkezdsLM=; b=KvrlyQAHWU8GRkzgDVkNdGoMBa
 x39EwnTuGBijF9ybGjcEcdaqCEPYYNiBTA+cn3VEyLUqLuWgt3XYJPcib1g248+v2dJuRP9UqjIZE
 QPFoqBY6XCf3+mpKzOGgczFSjuyzBNJO2RC/KRCzqmyco0xZtxVFeGuo/xK9M6ZYy/A4=;
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jCW3C-009nJh-V6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Mar 2020 22:11:36 +0000
Received: by mail-lf1-f68.google.com with SMTP id j11so6224883lfg.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Mar 2020 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f+nbJgOAkU3OKGNy5HAiFcAe6BZ2/dfnnfHDkezdsLM=;
 b=lLp+JNv1GIglmiE7sOrC1qiIR92TS5cKLDQInmmSnSrfr1qRJIqEePz4qZzmCMaXQg
 WfjeGL9/4gKBTTDka+GpLlLtpbiD1yloqRAJ0j1uaN1RPyfrSudbA4agtp71u5vQLvVh
 kbfpE2jpEmTv+gLLK2bdDBoWn9tFPGdA8uR+LZOOg0cNSMA//V8Yzq7FYJEWfGS9egxp
 ssrmkKAtsOcFrY+F+ktTdm/G2ys1pRbkX5kFFOvXt+HDZmd1myZbaTJUa01dn3e+L37B
 lhEYR0ODVOxYIzPOrxSPTQoqyVKo30x+HMDzyYjtalF/Xk6Pf7WKXUgxp0pP1/UDQYLp
 ZXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f+nbJgOAkU3OKGNy5HAiFcAe6BZ2/dfnnfHDkezdsLM=;
 b=kLE2m/dOwq4vvMZl7Yw0y83vfJld0GR0Bqr3mqOnPvhqhSdaOmJ5N1C/tEQgQdsRAX
 x5rmJiHP7JE0smhhhPKRsW/L4sQCLGF+ng+6hV2+NW7x3fuCVVS4cZKT0fBRq8q5ZerL
 cFNdBrc3zzPcJhVDUxh3GCk21WZoiAd7qfdVp8vYVxmCCfNF3LuUcGNp+IgBaTnMX0Zt
 IFQWfhRyumEunLR/IX/5NJh1synvW8gl5MRrOZxu7fQDGuSopVcng7cb3W5XnMC5YPWi
 f076rEwv8iDq2fSXOGYynvqWyu5Ad6NoBWaM2hEyW8GZv76sHNAdYoapSUhKrcIKbsE6
 hK+Q==
X-Gm-Message-State: ANhLgQ2MAGFeOBD4y/eMHe3yyVsOYKfP5l5lXT5PsAw73RfvcnV/JiZW
 SGl2Kq2fTgydpU5sWBtNJUn1GtD/6o4c90HTxc1ZWQ==
X-Google-Smtp-Source: ADFU+vuw+qDSh0ZHQbXiX986v1sXjlwq0l/RRl8ekqAVAeCDt4hyCXShVedgqdcfYfGOHvVzkalKAjAB5l3YONcMxRA=
X-Received: by 2002:a19:4354:: with SMTP id m20mr2516445lfj.166.1584051087657; 
 Thu, 12 Mar 2020 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200307023611.204708-1-drosen@google.com>
 <20200307023611.204708-3-drosen@google.com>
 <20200307034850.GH23230@ZenIV.linux.org.uk>
In-Reply-To: <20200307034850.GH23230@ZenIV.linux.org.uk>
Date: Thu, 12 Mar 2020 15:11:16 -0700
Message-ID: <CA+PiJmR=zp9P_Mam2EuVgy-vZftDTGQWuFmuO6asPeU_jEy8OQ@mail.gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Headers-End: 1jCW3C-009nJh-V6
Subject: Re: [f2fs-dev] [PATCH v8 2/8] fs: Add standard casefolding support
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: kernel-team@android.com, Theodore Ts'o <tytso@mit.edu>,
 Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Mar 6, 2020 at 7:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 06:36:05PM -0800, Daniel Rosenberg wrote:
>
>         Have you even tested that?  Could you tell me where does the calculated
> hash go?  And just what is it doing trying to check if the name we are about to
> look up in directory specified by 'dentry' might be pointing to dentry->d_iname?

Turns out I tested exactly not that :/ Ran tests on the wrong kernel.
I've fixed my setup so that shouldn't happen again. The calculated
hash there goes exactly nowhere because I failed to copy it back into
the original qstr.
I'm trying to see if the name is a small name, which, if my
understanding is correct, is the only time a name might change from
underneath you in an RCU context. This assumes that the name either
comes from the dentry, or is otherwise not subject to changes. It's
based around the check that take_dentry_name_snapshot does. It does
feel a bit sketchy to assume that, so I'm very open to other
suggestions there.

I'm going through that hassle because the various utf8 functions do a
lot of dereferencing the string and manipulating pointers by those
values, expecting them to be consistent. It might be enough to just go
through that code and add a bunch of checks to make sure we can't
accidentally walk off of either end.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
