Return-Path: <SRS0=+EsW=AS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C4C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:44:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89552064C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="BUYOC0H0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TptBDBFt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QueixaOa";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="i+8zrHE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89552064C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUPSXN2+MO3u3oEb7g/Pn4QnNO88fSxKw4+bNfW+ETE=; b=BUYOC0H0ooBIL1aNVGe4dp7ANC
	/yrEjJMKilxIDCZDw3ttecB9AKJXLxGwG4hO2RpeL+/BKhGAR2UfW0fCPKEKEVNcfsm2UsVBWab+k
	7wQX0Uo6c8NTnJF0vt3vDWN10V4eBAHUDamn8ckvQFdr/+dOlGIhh7J+qUyQXiR74g/o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jsl5O-0005i8-CR; Tue, 07 Jul 2020 10:44:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1jsl5N-0005i0-3n
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 10:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=; b=TptBDBFtcEMPc/c0nZ5uOXjHHx
 VgSKgq3Q8t5w74x1u6Hq1fU7Bv0NeYvHtyFSLY0pol69UJO+FDBLtvojtl+vT9kLFMQaIS0hlrx3u
 9uzlrE/aFDokrtQe3SnHeUG5B2g913GMRC2dq6kFat+O2SiWIEsqMaoKHb+uVR+Kp8AQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=; b=QueixaOanQfVtiaPtB7Gvi3UoF
 Qb0K6uAFJ2Ij/rq/mrbFLIRWXQk08HURxtQL+IMBlt8D9UHR9mRsNSsc3+Eoxy4hkICgSZ38i71V3
 sxaO1Pr6MsGMvpUfRBtwG3XjnId0bNLGGkNOcUTui+OUGXvN4brSZf0WsxuseoYYb+Bg=;
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jsl5L-00A6Rq-7R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 10:44:25 +0000
Received: by mail-oi1-f193.google.com with SMTP id t4so16679263oij.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Jul 2020 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=;
 b=i+8zrHE/fs2Y8R0mSJSYG3HjDe8DMVO33zE9s8G+U3bPlySiM1KMfVq7FQZXMQAhf1
 1otQWa3z0Vo7rjF4WrjRMSTIn13HVhr/JHalXoGUunpOX7WHRLB3zlFjoS1E2nKKej2L
 wWpZzxVUx8xWAMhvXDyMkaCaV3SfS6vGC00xyBcxsE3DhCqezURHXrD0RavIKX0oj+sp
 /oPMgxrv/HUucbo5d4BmjphhcwAKuEq5xOk51hTZk2do4F4w3ppJDidPfTL+qFOXKgk2
 BplIYO3/hCX+Qvdwhdxy7PAM/Rm0Np0kp7ad9ua2RSY+KL50IHQX2mnutETcFSLaBndV
 Gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=;
 b=WUHUsboGIkIhAWstE+DPLt+6ID2dglvz9urhwU6nm+udMAK1YzicLppKAZ7EJb2lNI
 leCukj7jTJcpdi7XmbP+KsMymdlRh6DAnQ/gvHtjeJaX0XCjRBGNE4Eei48ByyjLz4/2
 MyuLJeJd3etbZNg8hZhApWNAHuLM4XOb1lUqr+4J2PssKjRHK400iVhIrjY9+rttmhig
 qWvs5je0axbh0lLUgIfMXloRd+lQ2GT1ck5NKU7fldo4qqCGO0QnfmcLXUbYZ/ShQYmP
 /A89YEJZzx2xdVdsi149AQrLXIXjDPvv8yTdF3VorA7uAvLzhXNqBmS8yCXk5wrgiUW8
 NorA==
X-Gm-Message-State: AOAM530JXx1lS7c339ctxzNSuuOyo7Li+OeD52hdhXABFLOrfMEX4ZME
 yTN9geYrfJU51EAtOYgptWtgThELCgfDyGu6iCXNqg==
X-Google-Smtp-Source: ABdhPJz+TeWph34DQmuzU5/HwXijA0+NDY97HXcO97SKerniK7b3Ulr3aDgUOA25daDJjAs5gvkPux2OD9AQjmHA6HA=
X-Received: by 2002:a05:6808:a19:: with SMTP id
 n25mr2626139oij.84.1594118657366; 
 Tue, 07 Jul 2020 03:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-5-drosen@google.com>
 <877dvxggsl.fsf@collabora.com>
In-Reply-To: <877dvxggsl.fsf@collabora.com>
Date: Tue, 7 Jul 2020 03:44:06 -0700
Message-ID: <CA+PiJmQN6Mkqq3aA+v6032QZehHs2sTqthzM-NqZN6k3jGBJvg@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Headers-End: 1jsl5L-00A6Rq-7R
Subject: Re: [f2fs-dev] [PATCH v9 4/4] ext4: Use generic casefolding support
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
Cc: Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2020 at 10:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Daniel Rosenberg <drosen@google.com> writes:
>
> > -
> >  const struct dentry_operations ext4_dentry_ops = {
> > -     .d_hash = ext4_d_hash,
> > -     .d_compare = ext4_d_compare,
> > +     .d_hash = generic_ci_d_hash,
> > +     .d_compare = generic_ci_d_compare,
> >  };
> >  #endif
>
> Can you make the structure generic since it is the same for f2fs and
> ext4, which let you drop the code guards?  Unless that becomes a problem for
> d_revalidate with fscrypt, it is fine like this.
>
> --
> Gabriel Krisman Bertazi

I unify them in a later patch, since I end up having to deal with
fscrypt's d_revalidate. With that patch I'd end up undoing the export
I'd add for this, so I'll skip that for the moment.

-Daniel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
