Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05827C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Fl/Pz5igX6bRM4IBc6fbtbz2b996qpYvH87mIk+b38=; b=Ms/igVg2+NCOpqHwqCVaziNS+x
	9cJfOeB6shGKXYJ5bJmhDthY8Dd2BBIoMBcfMhS3codmZ5Ja6qQf6AQAjpsKK4R/mK/m34SfDUB8i
	eYgNHCLGHE3G6Ko7XTENpNQWM6vo5l/F9022zyGabpXfgbgX/3XbAjSIBCFTiNQuVkJg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjUEw-0003DQ-H6;
	Tue, 14 Jul 2026 03:55:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rollkingzzc@gmail.com>) id 1wjUEv-0003DH-Q5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ps/y4fiShT4iCP5+YZjWjcevnrJtofEmEQ6DBYMQSTc=; b=Vqj7s19ahSpObhT8qtI3dazvHB
 mpIZmTctUv1cUAtjloAAdvzKsM4TBWcAn0M9b90t56hGYrkoB0Z7Z+JrTXCiyDvNT7Ui7cFNAPuNZ
 w5DarhP2eMvYwuSy28iX1x9OOX2CAJ9yNOYtWzaKvoCZi4qEIUsUVQPl1PZbU9P4oozs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ps/y4fiShT4iCP5+YZjWjcevnrJtofEmEQ6DBYMQSTc=; b=BeWyd8OjkrZ8a5W3fJAsYmzv98
 +El1qowxPpyrBomEGGY9kdR6QCJslPBf/qlAvWT3lphmL7W63BHwakjyoR5LwN3LfsmGIcb3ZsT0h
 xHrC2CYog8a0hnr8Ykv4llNbJpFVR8Z83/xqgZlSU2vIpatM2MFoKY6nB3oGisfJZjoE=;
Received: from mail-lr2-f8.google.com ([74.125.230.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjUEw-00038m-6o for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:55:26 +0000
Received: by mail-lr2-f8.google.com with SMTP id
 38308e7fff4ca-39d9716c2daso9363481fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 20:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784001314; cv=none;
 d=google.com; s=arc-20260327;
 b=ozCm0/1HDAZNEu9nbwWnSmnazdP/w2zbXA9d7PK/r9Wv1n4upzp/XcUbVKjWUCGfMi
 vr0MHExu4pd7UHTr7LDqD6be0jjx2eYDopHHaqNQip5jcIiKloARvN1VErAsGym50zkR
 WnjZaAEEUXJoAJjL6DJaUgjYzVHxl59mnm3MQEaHxqtFmLwmohPLZABJZDwjuMh3EbfI
 S8A/aa9qj7aA9YvRs1+0eakYyfk7GG/X3Hz5lV7FCTu2NbX+Qe8EKVQadlE7b17y694w
 Jrknp+wo4kvnueZiNt8reERIseCaXV3NzxhFR7N205fNAAWL2S1pLgTa0u/nzBIMm8UZ
 Favg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ps/y4fiShT4iCP5+YZjWjcevnrJtofEmEQ6DBYMQSTc=;
 fh=vbk+CfFsl69h+x2iIiA0z9VTxMmyI/InQopVRZJF+CQ=;
 b=sNxh/6sDaEhjazS9PP1MmWXDXt99N5lXv1washojJab5Zz/b0uRWeXgtn0m+wmAPe3
 9AZ7o1dS7XoffcwqofvFFdeBSGEKCVznTchV/x0CJPocpj3LDTHxZYzKvgU+Nrky8DSX
 1EkbrvAjwU3N7FxR0I7JivxMabusWsKKL98webB7A5TrWJMriceuMkWp1FwaYx9yQrgL
 jANIZGoMUst/x88yuQehceHN+pv/K042XF6HZ03HInxAZhb6kz3uVf+w139FreFohCHG
 iowcQ/AbxSxj5x2VsiS8P2MidjnVqJCEix77Q/5EclfDO1FX9mC82UgSZESKnw0yIgk6
 hOgw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784001314; x=1784606114; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ps/y4fiShT4iCP5+YZjWjcevnrJtofEmEQ6DBYMQSTc=;
 b=fsHS/uCHt11F5jNGX9kuG+n+yUo8qFu193f8D5cZfz3Nnz9PeFg79XAfEeyinhcHcA
 c048D66kC9bu2zKBRTWgJ3QjyiQI6ztOLzjWw7v9uIaH5hphhWMXwMFvJ280Nx5OoFzY
 L4xYzWgmv49wO0d7AtyRMSIp4SOjueaaA+HAis77pNp/t0/DA7JdfET1ptuOHljBe43u
 pP3t1noFw066Bpn5sKQCR1+ztQO7+R1nSiDvOKnGmACvr4K1xIBPIJgQIehz1cn23Bo5
 m87xQJ/jfZrgGlw8WXR1te9jvAxayAnwC3a6mYeiCoFU9IYaHONusP8AtOHE4fljLPqA
 1fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784001314; x=1784606114;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ps/y4fiShT4iCP5+YZjWjcevnrJtofEmEQ6DBYMQSTc=;
 b=TuXjN+paCnjm+E3/osCKU3jzbH5gq3pnqSyi+fwpIKpJem6X0rsvXHOhVVcvm1YvMN
 +7JBFQOdw4MoNMXvxvdHdWniAFmeocK+N4oXP2M7LSQuApQnAXr5m/ZyTgkDNTDCu90S
 ye+tpkXlGwHuyO92vJqBMMrR1mJjmDbLTnLQIdBYsdJGMmOMxf7pA9dFzfzxxrzSMmpQ
 Ap6RF26frnwOXCbkBAWDib/sOprv607PNrqFr362KPB0Idj6tqRLpHFXFNGCNgutBO4q
 52NnksSuWCR18W+R41+GYvXai6AfN6dTd6YChzfHHZUB5FnoW5M4tSfqplnyLgA0duNs
 Lp9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYfWwDhG+Kg/lEK2HkWRV+TbISqD98gYW/MLwEj8/tTPNnU37VHakMJmz/iD+Tmvr2+IDeBc5EhJjBhCBrK0el@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyvIfS8tTPfuCedm2SXTRUd8gaFVUXhkAG3T4pUjdn8eG67xWsU
 +yOWXQ2f9BaAtSgIeISs6XUSRqdHziVGbMpdp/oujpNkPeeler3UX2LbeyUmSNSa79OD2Zaqt8O
 mpdJsdAxS8LCttAL0tAyGHbYZG75eH2gLDAiqfb+W+EM6
X-Gm-Gg: AfdE7cmgkNenGoY1EOW/5Gdwf3gbzBIOpPAEf+2gJHZS8vZvzovzapehbGoBn2X79ft
 yUtGAzOBhELIN4iVyqQW/s6+oNIOZnaREE6efr0Y4gUCTI8HWOef8pQIyZo6fCHXFTT1qZ347wD
 Q5Nm+uSDn2Al+Em0lm49VYarZphGkTZg3eisVUWqpLHPS9im1jCeLxoUF1DR1EgcfqAmA5YFwu5
 OKO4+SoUprY2MCjB22WdRg8BpkCirm7vg1PgJlsJ+oS9kGJLNqUQVzeDPKYdGKT8DLMFxbwd5NY
 OZS6dAGUaEIobxSb92aOvqQguZkkqJrTE+DzwIOQETqCdAaXO+gyNa0=
X-Received: by 2002:a2e:a545:0:b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-39caa104039mr22689641fa.3.1784001314069; Mon, 13 Jul 2026
 20:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260630142046.3145107-1-rollkingzzc@gmail.com>
 <CAB7XQsEuX4Ctbz2mSUb+qWpHVfN2Q6LcToxk2Yo6QQt+o01hbw@mail.gmail.com>
 <alWhJCTUnPXkjryW@google.com>
In-Reply-To: <alWhJCTUnPXkjryW@google.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 14 Jul 2026 11:55:01 +0800
X-Gm-Features: AUfX_mzJt0O5aUrCQfGj_JxSKZwf3EuqJgt3nnKFqRD-yyFVGUFcyFWAQmPdFvQ
Message-ID: <CAB7XQsEbiOD2_FJVc_o49=r9DMEMsTwrZhSsa6MPjNXpzfEZSg@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wjUEw-00038m-6o
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: protect gc task pointer during
 teardown
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

> Could you please post the original patch again? Somehow I can't find it.

The prerequisite patch, "f2fs: embed f2fs_gc_kthread in f2fs_sb_info",
was posted by Chao Yu rather than by me.

It looks like Chao's v2 has now been applied to the dev branch as
commit 1ab1345217aa.


Best regards,
Zhang Cen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
