Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2128C624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hZbNRaoHPwkRNrjEu/52IlLV3005BEdWcmmioOkbI0=; b=bQl/UxGNK35NmBlmfi0slv8QvB
	fgAqnSQqxJ0D5AJfJijAJ6qFPTvH+MA5i5xhtzHZvYU+3LKEnYNZPJ6mWk+kwpTeDDDppnGSW+5ra
	18jkRl/eb29Nam6duUIioatWzGX4B4nWiUUn3T0j3XO9cpwmm6R9OOn7WcLn2NPmlkpo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Li-0004Sx-Ip;
	Mon, 31 Aug 2026 16:59:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Lg-0004Sq-HO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CsQfL1tfliO9VnEQEMentzg6G++ksmXz6fvZ/EjRAig=; b=JkQHf8RNufHiCwwiFEROW2EsC5
 3tj+LTKK9VerwP2KHEugO7MHD9sihvW+Eqm2Mb4+KXdFHPVj/uUMcypvlBGxPTFy03di2d+iq319I
 VlUgWe0vTf4QEGXCZ7tEjGld0zKr8yaVYNChxqcPTnHaubFb+paKbyegD1cNcP84t6q8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CsQfL1tfliO9VnEQEMentzg6G++ksmXz6fvZ/EjRAig=; b=MUhyUoCTJdU5MqiwQiNgJXkG8i
 cd2Y98YU4FzQzhFYNO29USdVHPEtFuPHM9QehwJzsT/44c7awY/DaOgZMPdhmPnveRSt8BoOSTybm
 UOC5UOYcuiV7JzFdQKnWXk1guaQ8DSHX4EnC6QN++0vK9SseMETgbhvNOnQTWVVSDqtk=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Ld-0000xa-Mc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:59:05 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso4838851a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195539; cv=none;
 d=google.com; s=arc-20260327;
 b=B9q2jM2JX61iW2KNPzo6dsZy7yv0t527JfshmkpI2BWkhiwBYcY2bhfc3gTT+4Wj42
 OwxnWLjdc/ny5lVYnITgtw2LIaynInpCoYsOdBkWETsm5edMpsBAplllI15j7mX2j8is
 daVeZBUSx173JX9V/F+lf3Lh0udIszJbVArnrWkVeMb9z1RVhxtN/kyGtiQjNRxJqVA1
 8i54mQxrv5F7et8VV1DNhHkGc7QKdCdFMmUbip2ohZItzC8eeb89X6TrMcuSRwHOZLjW
 hN+jT/whFOX3p7oPJqFSQC1kvjOXQVL45biX5bWJvgjwr9j9t8UyLmONmJpYS5hxjzL6
 yDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=CsQfL1tfliO9VnEQEMentzg6G++ksmXz6fvZ/EjRAig=;
 fh=1DOvgAoHRjMdQvu9ke6EgLAjq32/u6YpA/NVBgUgMUg=;
 b=CqV+sgVomRTQSniRAb6Q19pkiy4CIT9R8MPZtehgUDBPbE+zV1Ic0orYFjveqbulUT
 xmWWSRQOfQ8yOmKfxf54G/Y7z3PojdliEKurJeXLcXSeieJQEaGeUzIVd8Kl5cbcARAc
 RM9DZao0+cZLHAMQghPayfPIE765Nfuh4unTSpFrgQV9ZAnfj03dNSk2ghWnwFmkv7sY
 fPL6XdaL5ZlPAZ4bgDrT2RTyyrWyJX5RVzAUapq+mbRZGbhBBbjgK0W3QziTVEkL0/Ah
 SFgVoAz+wbya9pfmuBBZ7RmAfNGne5lk25CP6AXagh4p9TgKDwlQUEeX/HkrVJp3ugpO
 5vrA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195539; x=1788800339; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CsQfL1tfliO9VnEQEMentzg6G++ksmXz6fvZ/EjRAig=;
 b=QsbPSNWQdrggeT8ECd1JLMkOsLhiBI5lObQ99R33Ip1s2D+N3G/KRd91v4tliHqbun
 8v23C7lxu9/uWDG1OSD7yLUleNjmwRSTUDPabDQYUAS2OjH96UxA/fUwkuXJ62hY9rsk
 jIapGvojYazJ+/IVkNr6wzvX1r4hMBg8dzWj+bvIqdVHcr08kAZq6TjwUMrvlU+3W3CT
 kRXtqmPKINFoDu4yqr6UTDK1avI3f49S0lj4Ojy5NmmWRh1mwlvMYcc47tgH2kPNzP2O
 cQPvuJmirapY45Rmy5o5Wd0HMx+rRtGBZyo5JsbRHtYeNyfAjOEG5f04HMJeQDT6ipU6
 rW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195539; x=1788800339;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CsQfL1tfliO9VnEQEMentzg6G++ksmXz6fvZ/EjRAig=;
 b=O3ottuY0KqY3OpZLelvJNBzuQoBSsGByhUfEMquL0Cd4T6xYWWH16dy6sYqCIFb7g/
 rVWgca57ibURZY4ZM+dWsB7rvJXJCLu+KIakt9/Tokw2qIFkZK5Xr9VIoJwO4S2Tpf/l
 yqW+03T3Dx4mZSoRWWh5Al/NByTS271gfr34lE3J6sGT/2d6SBanp53ELsfN3TcbvOW6
 Xa2Wjjv0+qsTfw/Zeu0FIiC86gGgeK6GEYZMvk0eAUOoLY4Jl5djeloPdMDMAsP2OQyQ
 bo9iHfndTd03GFQ8QivXabLLJBGBNWQLR9gE+n7XyLqhyEGFuWgChIEDU56KPTI7af1l
 ktRA==
X-Forwarded-Encrypted: i=1;
 AKwUvByitrcyKtpLUn+JreWB7GVeO+ISeWxHlKD8/v116bvj3gkAq68A0JmQvrCAJ1EhDFJOLBriN+uwkvdooRcZkxQS@lists.sourceforge.net
X-Gm-Message-State: AFuF++lTKxYGgRtxJEF5AylB9EpbbL03BmaMOEUYUrfspe1m8RzgubAt
 rIav5omdfRxZgMN77W4kZ1Pe3T0tfgSYuxrIb0YsUoxh0Dl8cCXemsUjUGAxyHLxkdKapqaUnQA
 9zHaTr0iNvtvRq77oVHN19PjiXR0kLUEHKrNhq24=
X-Gm-Gg: AYBFou1zreg5SpYNWUqyDsVADmKfEMQTx/JWs4IN/CaMVMuLheNpsBIdeaHPt23p/8t
 4t6oW7YULijOUh4Qsb9JWig1/k6UHfeVtv+oDdiB7ytYY2mAQ3bMnfAmREVNummeZTGuO2tIfQr
 ayt1hIVv/iMBRkf3xpkM0ywW/Ka/C/O3OxGOt52HgEAJyPvhcjah5onrLNnRDBH93/rNDgaxXrk
 iPglhV2uSVHcixir6+fvZCDP7uhB6ueAiTkcGyeePNatACjTMcjhfWoMzOsf1sPm3j16qAtt4Hr
 h2kqXg1jyXsfFd9tx+dYQ7J7xI0flvb+8HFDJQnY0AoeTCznoPXmVdK4IwcJQd6qeAakWWqnJ4g
 9+A==
X-Received: by 2002:a05:6402:3509:b0:6a6:32f9:d7d0 with SMTP id
 4fb4d7f45d1cf-6a632f9d92bmr7965344a12.21.1788195538559; Mon, 31 Aug 2026
 09:58:58 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 18:58:57 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 18:58:57 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69df3654-4f5d-4f8e-8860-62e545897192@kernel.org>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
 <CAH=xXfHL4bWFMVa=-a8sRuR_bn9VcaFRo+X3eeZfedSa0C7dww@mail.gmail.com>
 <69df3654-4f5d-4f8e-8860-62e545897192@kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 18:58:57 +0200
X-Gm-Features: AcwNN1VwC0SeCPllS52NvRnYaVl9oX696Jt5ylne-NYCkQLRrEX8lr32DGjiAPU
Message-ID: <CAH=xXfGNRpY9y6p7u6dJwUqv2ct2RX+W=K8F0t96hJoA-tMkzQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Ld-0000xa-Mc
Subject: Re: [f2fs-dev] [PATCH v3 01/11] f2fs: initialize sb_info early in
 f2fs_fill_super
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Sorry about that. The previous Gmail API send path encoded the patch body as
quoted-printable, and the delivered copy ended up with hard-wrapped hunk
headers.

I have switched to git send-email and am resending the unchanged series as v4.
I will also verify the received copy with git am.

Thanks for catching this.

Regards,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
