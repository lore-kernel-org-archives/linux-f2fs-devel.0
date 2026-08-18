Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3AEC5DF7E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuS4pS/Ag/vpG4lCfO38F05m7IWolEP2iH/FqibAU10=; b=KnrW4O90aRltH5M0PAweM5DudG
	sGrvHG9g8hBtHth7RlD1J6iXJQwMafQQil/U9AsZweDEWZu42jQz1Oo/VDTWVjHnlLo4P35OZ+aGv
	TBZIDrwPGgL4R2pK8BoqxsjvZIo1ZXgdeo4pzbkRCNES2XdHq79sd914nEVo2BawtHGc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwIr9-00075O-IB;
	Tue, 18 Aug 2026 12:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1wwIr8-00075I-Sp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHjPq7ZZ8r5ZGCIpHL/Y8j2yYpB1slhINAbeMaIwQnY=; b=WF2CjI1XvvKqkGbPplUHz+MMNp
 mg7LIrf7YcvHF8GzsvkSuAKYdr7jCj+jwG/1BOjG4qgwDZv4ncsjwoLzdlJBpKX7PDmF8Puyl5XHQ
 R682F8v7BH/b67sasO9CGwefU7vLFXBpqXd0R4To5BS9qsE7UQdRuIBNPHSwUSD7VeYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HHjPq7ZZ8r5ZGCIpHL/Y8j2yYpB1slhINAbeMaIwQnY=; b=kct/HKCP94R59Nx+W6cmVa/Y0Z
 4q7NcRXBv5iEyNAkAKLvexNRKNn56gYxCGt6ITBZefPIBLPN3cqaUv7JuQbgAtlR6PucRiMefscrC
 qNwXTRpgRL5wz/R77DZzAml00vLU54y3dSjo9DQ+jDnWCbUsCOOc0rGGB6URPegbxsnE=;
Received: from mail-yx1-f41.google.com ([74.125.224.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwIr8-0003tn-Ky for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:23:48 +0000
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-66c70d3abc7so5959128d50.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 05:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787055821; cv=none;
 d=google.com; s=arc-20260327;
 b=UrMEMa569OvwWixz6DOP9DaplksQrWFwxUla+UpsLdA0ip52r/LWUnMib0NUfBXz+I
 niA2BbZdsWolmWus5njzz7y50na+hmf0An5MgyXCq2xHWX6Z7f5K4SD3jANxyA7feV1f
 wYNsR3USmiGMsweZi7GjCgbHbqiSdquz89kdcwE4KiWyiWyDbM3kyDtC4QoPSNsV1Js0
 FO9oZfU7yeJ6/DLC3tKINxTfsOBi3THBRR5f4BiL6gBKdMDHBMrCMuq6PzkH/sZSkKFI
 EQXWSqJSBQDfrLDs3FdRQ/JgdFARaPbYpieGAJMiIfiougKqYtdY7LZ7lIUQ6iddBA0p
 zf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HHjPq7ZZ8r5ZGCIpHL/Y8j2yYpB1slhINAbeMaIwQnY=;
 fh=XpH0VKrfaudpq/NrS9TMCu/f001rbS2N5NboMCLKrDo=;
 b=Xir577ckc3zA9ROXLZSwYLOknJMu60IuuOk2EosYnGN/F/ti34mNxsqW6eNWGtmype
 nGiBtOnxWDcNqm3icHmk9NkUZyVLz1xp+lEWMWYeyKTLTYbEB/x40+HTKDgph+/2uPOb
 18Ui8qpFyx+bShLt07W0jgODDQM3O/gAWYiF3BQcYu5tB3kd/okk9UmzrNKlmIBbZvTI
 oJ9/6aCNw+6oqzAK8qyqnW+KxbEPkc2W3yiiSo9YvggrJPy9vLD+mFKmmms5nOrrTBCp
 c+TI+Du4BTNwMNI11ieL5FTrPqs+rEXji0Ow6LBc9MHvIj0LKsBIfxZgpvblaiH26Zuc
 p2Rg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787055821; x=1787660621; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HHjPq7ZZ8r5ZGCIpHL/Y8j2yYpB1slhINAbeMaIwQnY=;
 b=CNwqaUT94JCKj39lZiMHtt2hf3RK/jIefz5JMMNyhAYSWByki5gXstvJ8LZxQqwtZ4
 SVpliJEAbQ4PZFTg5tItCA/u0c0TcFwmN/vHLkIKGzIYxBOmvd25x8R3tJUTQeSYaKoO
 Ul2BXsYMwUNlhREDN9CDtwbSiJRZUouPGkPvMRGadae4fJcSmHlvn08JGEovSvqaj/mn
 ugaLSc4L7Y5SDufmuRen2aJBwbOnKRLAc0YoB4F7nApJveM7PhN73yOSzUgOTxweDA18
 uhipF8PNh5McfhjhIpAVWKAg1YAe4fYM9vZEKezu9nMnEzUTGxfK88nEIhSKtEZWKG4W
 vq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787055821; x=1787660621;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HHjPq7ZZ8r5ZGCIpHL/Y8j2yYpB1slhINAbeMaIwQnY=;
 b=kCpFkA5sSnSVi9NvUWL5DPW9Qg5uymtLD/lG2czq+NBKK+hqdzhFZ5/dliZuKf5Zoe
 WdjLJobLPCEm6lFn7RCSyCrok8jfFtbFo12b5NZP6+v+TsUK5UfNLUHTvkJzjJCs1P4D
 U8c+s/dyWo7Vti4235D97DIBBfiIT3sgqlEsEJxOyXUjVsq6Z9E+aRTWDGCtrIefb1DW
 M6nhJPOL6/w2Tl3/u3pHuvep1x4cE7e28M6oStNZ9gdHkbFQ45p4nzpKYjkrmUeuO3AC
 L63dPtW9Lq579mRSuPfeaXatbTLAlk5VESSHsyvzvgO65Gqd6eP4Vg1S9dzykerEzh54
 bkvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsA2ptEdJTzKG2l//clR2WsshChDc9bdqFP48B25YT6qjCezaXTHJDHU+AEnOV6MGo0UmJ//Ik3jwMYuMAOMWX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVSH7HD4cyejqagYkFgOfGLhURRecCbkClnzPqCe0YGacx0TP4
 2xdNott3O7lOMyBBm0y5MT2UrpZkdvS57KuR1N2bJ4YgZCjW69N7MHvpqiFiPNGIJH//5P2qGst
 CFMH1myYnwk3WyPBe0xgHQILB0dKMdoI=
X-Gm-Gg: AR+sD10Ij14mP621oEzQLBzmn8/LdGKxofkLYfcfazy2he7maRW7QFnlowhtl8HLkig
 xdKIapkR1Ar70HQx46i67J1FKoXg2hidzSfbsbWYRUvu97/ZyR/gbmcT99tdYXedLdDuEmz/6QY
 8ZmwN7RX5VMWy3iGplmbcIt97//m/o1UnDsYXO+amg/2ATvoEyz1ujqm+zFDGtOe9zLoYJxjUF4
 GkMwxSVbGjHdobinJbvqfx1kKHHn+oCJcP6NgrWNy5+yc3IIObu5qnWJAkmrIrmNyZGKJ/Ofrvs
 4sVpipzxT3GTN8/pSiunocalS2e7CnWQdIWqMOf4fvbSDw==
X-Received: by 2002:a05:690e:454d:10b0:667:e04a:8a3f with SMTP id
 956f58d0204a3-66cb9c96823mr2193159d50.5.1787055821204; Tue, 18 Aug 2026
 05:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260814105234.31620-1-jsjlee1020@gmail.com>
 <2a3d8702-f7fd-4013-8181-d9fd68b6aa18@kernel.org>
In-Reply-To: <2a3d8702-f7fd-4013-8181-d9fd68b6aa18@kernel.org>
From: =?UTF-8?B?7KCV7ISx7J6s?= <jsjlee1020@gmail.com>
Date: Tue, 18 Aug 2026 21:23:29 +0900
X-Gm-Features: AcwNN1UgakL3QQJ5bGXmxeMT6jgyeKCQbLAGSAG_ALAL3FlPJLvSEN0mstUv4Ns
Message-ID: <CAPHXVrzgPpxgAJrCmJ_Ro19AertMnqKfC1oW_y_FpbLoqO7nug@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wwIr8-0003tn-Ky
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix O_DIRECT cleanup range for append
 writes
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> If generic_write_checks() can adjust writing position or amount of bytes
> to write, shouldn't we access iocb->ki_pos and iov_iter_count(from) after
> generic_write_checks()?

Yes, agreed. generic_write_checks() can adjust both iocb->ki_pos and
the iterator count.

I noticed that the pinned file overwrite check uses pos and count
saved before f2fs_write_checks(). I plan to keep the check in
f2fs_file_write_iter(), but move it after f2fs_write_checks() and use
the adjusted iocb->ki_pos and iov_iter_count(from).

This also keeps the change local to f2fs_file_write_iter(), where other
checks are already performed after f2fs_write_checks().

For the buffered cleanup, as in my original patch, I plan to save the
adjusted write position after f2fs_write_checks() and use it for
f2fs_flush_buffered_write().

Does this approach look reasonable to you?

Thanks,
Seongjae


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
