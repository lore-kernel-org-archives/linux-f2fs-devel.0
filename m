Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33F606A8A7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TM0ReVE/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CLslheb2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BbhXXZYl;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eKAG8MKJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=2xi1Tem2wm8ph+cn7Nm2vxDU9GnBEmrvJk0vOxoAs/E=; b=TM0ReVE/blpyfIW8ZuLV+ul0yk
	Z+C3GxD0sHZ2FN6P1OPZUmZCpY4vZmt/NalE8ln8LA4nJkMcoH7Ybiz5gQSvU6WE1oXzK0vwtI6eH
	0xfUV/LCpCAZ+We7n7ftASwDJcnz69o7nFNP9r7GvnadQRd03DJ1vh9CGB5/PCoy/MAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTEqs-000000002h0-17jw;
	Tue, 17 Nov 2026 08:47:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <david.laight.linux@gmail.com>)
 id 1xTEqq-000000002gt-2pEp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=; b=CLslheb2CJW4K36+rGvgvhzMlm
 wQ1IiHNB7qkRn2sNatbZ44xV6XPkBl8UmdQwHN2yizG8cNrHa7m9+tVVDQWM19fKFt0LTunkGSpqC
 /bLLQyqvWtiye9/Gc9RgcbhmjgIPJApxznRSQllASPplloMfnH/T9Kl83z31AAKdOGjE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=; b=BbhXXZYlkqUpMqSCgjPyzIhDtc
 Cqw6QOjcQesfhquVMx5Jhb/yVwZnUMU+UqmPOxSc3cJZrnkWd2RROespRRk4ksIjTSnpbvsAlmdmH
 IwQjJcJc96+YDRHFfRKbNmfisDgqr7UZ8ea3xnfSSLEPATuxQcoa6Zgz2jbaJaxO0s80=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTEqp-000000002Mg-1IcZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:47:40 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso4169633f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794905253; x=1795510053; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=;
 b=eKAG8MKJFa5zFi5WfdmYOHbdjM+qybp1ifh9U0cYGMGC7RB7Bit3n1SpK5vBRFj8l1
 gtQoh1/UCDgGx8Xv4oNTnzhUukdmjHv5J0gkUwdsF+vX0M3gIxSp5qr6NOyMEP7SpgcD
 h8lXkrZls0WARwaSMHYwFwMzYISNvZPUq/bTkfsxUja2NZwfRR7YKxkM8bvIQ/O/btTC
 v96Me5sNNTdmhF2OSE2dQJAMSPz6SApCgY8nHLAKPCfx+MuX/T5R5YukcIN18OJ01mym
 7FKKvqN68JzQe5I6KKfsEYmlIbQBPeslfi6aki3LyJi+euPQteACbWFKcw9odl4NYDpD
 K1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905253; x=1795510053;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=;
 b=dKgRst6RzbbJOL6rV8rc5AForeyX6NJbB56sloKsDjVP6aS6vIJ2l6XX08KDfB4BRV
 t7cPAiPJLe+ZYQLeYztFI9wnAdv9EcoRzoYY25ItXHHcVUrTeEsBiA9bM3VvqwV8MmKF
 d7bo/BxbUHmDtNJgPw7yF6n70V4kTTgZqKkQWzGbvdaI+Ef3tt2xBgIyc5CPM6fLQzfi
 LzdTGC6SXlCVpe/7OOsnX7Vp02RLH+IIkgZQNubMal1H4NdS0aJvsNmpx2np6+FdjYCn
 gQ0OooMPkWYy3g1F5A4GxgL2mlulPkzCdqb3ZAmyKxGUNk+qcGkFSDqJ/edXSSvsgx/G
 WekQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG9App1IVYDqYdMnKxs7G+MvoLxmieLMYCHAkiEEgKz/gAtcGLdtAXCD2LVuHIZzy6Rz3cF/fnnc/BEYQI6k4BC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8fZg+fk85Bsaq0MsHVfWoVKMScQOEEeXwyrKRl8//3YswRwCSD
 g5kIJU5IuT9SJszJg7LekbwOrNxCxemMB59DG4cXHpxJM27fX7MqPyOG
X-Gm-Gg: AZFdTZfsZfCpV/4G0sk9bSii26MxWA7AHC+W+W2uIXvyOj/OmLyflBEKMUJ/SFWwaAj
 AY5/g+XBAso8ZlLm26eQpGOLDLXubjCKZfYjgYfKrgpznkCU2PorLcdzlORLhueJw/Keuacxrc6
 4jkQ9fX5wRenetLJIuf6jmsD982JCaoiGMoxAShbLN14Dea4VvVu/UXC8pQYkVU1Xl1mTCewgYt
 loJB8PfluYP5HElJ53kqyT+vLUxH4CytXLRzm/aw3a8IkjH2Y0w75P07RdkRmRvN5lSUl98S/N1
 CqOWGie3kxCYVEv9RXnVu4Ogwe1fR42h0R6AWMPz8Rkc3EQ8rDb7ktAZxpsrumfHHD3eeIQs/px
 +IoymLzH2FkzEQ1XM6GPG9L7BcKM2U0BbSrQRORI8dZNK6MAmb4tBJkl0BUiOht+jP80V/BZDQY
 lgbzQk4DuLSlmgpFdAcJQdoDhN51YxSbs3cfY4Rcqx7JL/d3Ov4dD23XbjvR0rfiwQN7ak/iqcs
 cFLnXvEHH3ZRMABZK2OtBbqwvmb4qhez3/RqUhrdnbh9XD5O8w0XcKBBqZCyhfQe3EnDslqNfg3
 S3mJ3txPU5Ju6H7dsczo32MTAl+AeM6k/xgBJYAxQG1QPPfglFEiNWiXQ8I+h8jsOA==
X-Received: by 2002:a05:6000:46c2:b0:48f:db47:6ebf with SMTP id
 ffacd0b85a97d-49c729bb31fmr19089884f8f.38.1794905252525; 
 Tue, 17 Nov 2026 00:47:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a43775f9b9sm2739633f8f.26.2026.11.17.00.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:47:32 -0800 (PST)
Date: Tue, 17 Nov 2026 08:47:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Message-ID: <20261117084727.0cfa196a@pumpkin>
In-Reply-To: <avu0X5E298dHRBHY@mit.edu>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola> <avu0X5E298dHRBHY@mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTEqp-000000002Mg-1IcZ
Subject: Re: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 21:00:06 -0500
"Theodore Tso" <tytso@mit.edu> wrote:

> On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> > Either way, this issue is another example of why treating ignorable code
> > points as 0-length strings was a bad idea.  I'd very much rather
> > utf8_casefold would treat all ignorable code points as foldable to
> > themselves, (i.e. commit 5c26d2f1d3f5 ("unicode: Don't special case
> > ignorable code points")), but that was tried and broke applications
> > that relied on variant selectors code-points being ignored.  
> 
> Sigh... I really think these characters are *evil*.  I wonder if we
> should simply drop those code points unconditionally when they are fed
> to the kernel --- not only folding to themselves, but *not* preserving
> them when a misguided application tries to create a file with one of
> these misbegotten Unicode charactesr.

Doesn't that assume that filenames are UTF8 rather than just sequences
of bytes with everything except '\0' and '/' being valid.
Casefolding is itself so evil/impossible it shouldn't have been allowed.

David

> 
> I'd prefer to simply reject creating them with an EINVAL, but it's
> likely that will break those stupid applications....
> 
> Eventually we can have e2fsck offer to fix directories with those
> characters, and eventually we can make these characters become a bad
> memory.
> 
> The other question is what *other* evil misdesigns are in the unicode
> spec that we should be preactively trying to addressw hile we're at it?
> 
>      	     	       		   	     - Ted
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
