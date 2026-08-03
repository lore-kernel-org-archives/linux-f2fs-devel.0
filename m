Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51433C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WlNoy3SYEqyf0pChrx95qqgLZIZEAcqYUK4vmEJpGI=; b=TSyeBfPk9mj4mDizY8+XX9GDAy
	s3ivPwHfPXV96EXx/snWaJ8dbQ7kpv+b7Gc5h1xcgElvUTMCo0cXrLtL8wHZ33qD/lap02ehU4CdR
	StAUyNpOj/46SNfKcJDXsL1eCM95/fyqVzIdNXdd+OQwk6v08XBL57FEpXP8flswa62k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqsyG-0001gp-5O;
	Mon, 03 Aug 2026 13:44:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rochan.avlur@gmail.com>) id 1wqsy1-0001gc-RZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:44:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=; b=bPoBcwUPxhoORB/M+vpxtOGc2W
 2AzftgOWDGerrqgDGUaaVbKD1xupPCAOz/OuHnqTN320wAPJ0iCJLE6WaPOdZUWWICrq0dNmZa4Q1
 7uENBQvs9gRr6O+5kTWxlqSnUx2nMy7KE9GIU+mk4jtH0XGlsbgmXpDa/ooseuH9Mdns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=; b=Vxce4lKk0Jdy4cPd2eAT7O4e6V
 vHfh3HULP72RArUFAbbOJTvvAJysGz+rKxKi0iP/J0YD81L+GR1x4lArI1VoVILNqDmW0q7gokT1i
 /4bWe/cV22VYGuycn6GA1SXjkEXK8AKffg1iI5HTQjFUG+u7DUiQszUrqx82UY97NaCE=;
Received: from mail-oi1-f177.google.com ([209.85.167.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsxz-00040Y-99 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:44:33 +0000
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-499f6e0bbabso1817959b6e.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764665; cv=none;
 d=google.com; s=arc-20260327;
 b=JuOGGv/gW4IbSVBcC7olUh89X0pjZxLyapACKmUNCv4Pvung4Dn8tkrzoyXSvOPF6x
 jkFN83c0QxEJwAtl9s8/8kXbx4ITjWndvDLTy9zuWog/2m1Sl7Xj3Pln+5ITE4BGzkY/
 mWc2UmZm6IaEIMirXpNn5JQORN7TOq4bjkh/NtxTOyh4TDbDoOm3+8hOoL4rlAakZ8dZ
 FwMUuALahVlb4ajdNF2ILoSh9WGp7kzYmnxKYgdNU9LjAW0Uu3tM2kZGEjMRf16f0KK9
 V/6mwKuZZWAbpJGm7lfHfQibUjKpkPDyt8fozgtdcAgi8o6ecRaofdooZJg9few+JrOz
 x5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
 fh=FvjiFn7YF7+fNzO37z4ZfV79TmIlEbcL/JS42vUKdt0=;
 b=fQOkZ+2Hs5RicqDFYk7W8/JhmwugjouccL1wr3hs9GcU3SF1i70X9hUkLdB3ams+Hj
 yIrKu7qHswgXLR4fSRKfoEAPKUunNPMw61wS5VGQwNbs/j1RnZ4zqtnOfTqtYKDnCEMa
 CtqytXaQLk8INvv5FyRoCbKqH8UfjfroOg7tbVygnCnPF1UZdKrIA5kTQEDZmhQnsH/g
 Sl+SLs4Go1wqeovbGRRIEnH2ALK5KuxFtw/YYJ3NaBvFunDAuf9A29Wxcr45PkoGQJ9X
 8XzyyUTUDhaEmesKWO+ib1d4k8+5h9E+IG8zEMHuQMIU2gHhFB6Y9gOFqIFUZd3Gk3o1
 Qe5w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785764665; x=1786369465; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
 b=eQM/C0vvtaMc1tpOaSx2/m7jqW8H9ZIUcUfihvsly3oQRb821Ych5x3MugjgdHYIxQ
 jiJkayPGeJHzxBNB70PmcHB4b5Oe6QVnxZebGChA2pr/hMn9HBMHfu6YaOkc+sSnvQuc
 S+LEo3Ilp32eJ8HAmDiNn0t2vkj1LePEzXc1qjthU0RFpfIId/1epfGL0z9f+y0fLp5E
 tlnvw6sIT6coLhZ1k4byrOaA2m+2W7EV3Xra64wZg2QB9KORjqnZA0ZP4wr6hqy+ph9d
 IxxULfPUMwF4oWzL2w19XGA819aEUCC4UT0zlBcPjjTcU6QYHovfHPWTagt9XoJOXIZ6
 nIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764665; x=1786369465;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
 b=JNeenNLVB+/FILyekIFT0PuAG4UxF4oqT2uWVWnEW82DdRfZqqDGxWg07ewATNvb17
 HLV5D4XsRlWhRfRFmEiy44Y23HwW4qO7Oy6h3yriwFMgo1YloPJ8gXiUw92hKhNYsGiy
 xSzVyjP6dGnsKn/7I6O6Dsj0whdziV1vG6CXBPZT+riJMzFFnNYxrj5XuFy/ysr5ujAe
 /NfMD9mtidbgqcL45Erj1m9CRZKMIKHa1c5OyNdgjHdNrNCv/6ThLKDHuWQBWcEA6o9D
 Y+tCO+4qT3pic8Rk7F3Wk84lAIjjaeuj/IXqYct2Yn7NDz4jkZq6A8CNwfXcwhNG2Ihu
 5sBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RorHz7KQFO4gB/lLghi0qu90fHWJ5KB0QjOu3a68q3CusrV9JgrqHHl6IDWtSSkSsAkRdBrivRYTCEwghHBieQt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzgPXvr5FG9CxU8lXdq2pb8foJpN9z8FqyUWTA8ZWbpiLtUJUrN
 DQOg/fARn/0uU0+bwXhj05qhhwxxBnaNjuafABBI1Af4BlowLQa0s7Fms3XqNujws2QJPNVcy45
 vMY8/gJyFfFLUWVFmDrY1rHdxsbH6IQ==
X-Gm-Gg: AR+sD13R8mVIxDpHvsrDU9Ixd2lKS/JMVzBCKBWIxBXO/IvC3IwW5YdBgzIENJ3bEjY
 j6cqdAtmREqdglu08VnHXVZZvrqK8x81iHh04ZL3GaB30g40JVg7ymZvFwrZHUx9OYWS/frk8lP
 RwGbYmxnpcFRHcaOxUDcJw6d2L2LAk3DSL1O7sGH9YEZMoZjlErbt0sSji/iG+RG++vf6IBR8NQ
 LQxLHGnLXpNLqLeA5DZi/YsAXJG+SZB2ClBb6yYaBpqCsfxrPDrhlVY4FQmp/Hj3urF2Fy0bBwW
 qXG/HFim5s73Z0Gtit1zD1Go75s14NU7djLq+bdKs85PaWxNU8euukCHvCeoqPdY33/gP7dyP7J
 E
X-Received: by 2002:a05:6808:6c93:b0:4a3:26b5:7c3a with SMTP id
 5614622812f47-4af5e30be0emr16237560b6e.15.1785764665292; Mon, 03 Aug 2026
 06:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
 <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
In-Reply-To: <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Mon, 3 Aug 2026 06:43:49 -0700
X-Gm-Features: AUfX_mzLl8Bbo7jXrfLx6YCf4GoDb9_Mldf-p0zY6jhglAo_lFsBPVJtMy0w4x0
Message-ID: <CALbtPkWdgFcrJLqPRfqVOsNgkSSB7H9+NhegeBqfU6LfdyF7Mg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqsxz-00040Y-99
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> > f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> > &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> > the idmap that was passed into the handler.
> >
> > Since f2fs supports idmapped mounts, this compares the caller's fsuid
> > against the unmapped on-disk owner rather than the mapped owner; resulting
> > in the actual owner to be wrongly denied with -EPERM. Use the idmap
> > argument that was already passed to the xattr handler instead.
> >
> > Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
>
> Thanks for the patch.
>
> I notice there is already a patch:
>
> https://lore.kernel.org/linux-f2fs-devel/20260716025908.608098-1-zhanxusheng@xiaomi.com

Thanks for pointing that out. I wasn't aware of Zhan's patch when I
submitted mine. Happy to defer to the earlier submission.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
