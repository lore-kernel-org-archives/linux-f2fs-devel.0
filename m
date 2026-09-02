Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70E0C624D4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 23:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0h7LuBhXugf7019rWbcwmtFmeaCHEpIA7zXatNqjpVc=; b=DXpAfTMAMUMClIMkeHB7Tskm5r
	zIdYINqWcpZs5R9F3Yzl68vmX0XtRIORmiKDPml46MgDSTxf3974Fil47FLjFmtsGQf2h7ftAErNW
	H50Q5xdydJIYqLu0Q+i3RiukorEereI0348OzQYw8G1s6K85ZDVHvZlGzMaHRFS2IoXw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1ukd-0005R0-Hz;
	Wed, 02 Sep 2026 23:52:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1ukZ-0005Qs-QR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 23:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MG3QiDYwnYyRJX/WbpqNA8DU22zfZF7tRC7pS5LrDa0=; b=g7nO24cILLzwybNRYVPSrTy/q6
 TYxMBxkjcJ9CwC/CqkKz2WanmZXbuG2e9jw2Ory1jdcFv78yNb2A5T16JeTr2vNHmI5R8ZViHzkkC
 BiwRG/hesXaoF18Y3anWgrKshZt4JOJ/OcKRme1zU4zOm3kaWN9mgMdTUDQBIWicDu68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MG3QiDYwnYyRJX/WbpqNA8DU22zfZF7tRC7pS5LrDa0=; b=fc9glPrgfuaD4PtFKaGI609fqW
 lj3sP9TgAtwMkCzl2VEPNAALlDErOHPjQHgShGQNK25ExDtBzO9FYWOnYY0f5k/fvVwy9JxG9JPSN
 zqVYzGZGESAnJjr8bNsbTGtzbnCZNFTD7L6Why83/XFKQ+c30KWn3/hjRsbIKejvhcOQ=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1ukS-0002mV-4u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 23:52:13 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1740141a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 16:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788393121; cv=none;
 d=google.com; s=arc-20260327;
 b=Ik7wxMmOmOJ2Z5xgq7tYZCvLnbkw3NvoKT0nQd5a5q8vPhH2C5CyKptRpCHyOGnvAX
 lHbOhCGKKnBjMD8wp4kiUKHE9jISLo/CJmBXl28ROHz8xwsaS0Up6tkTXzcYrzbMjm3d
 jQnOmuma7U1pwrCyz1r6qWMPeiG317vnC+9EkYOmRmhugypIbOLcrQpzYRxA1cUMuf4Z
 UOgtqXq1rjbRnPBZS8VhKzLEoX+1BIT/Q5bZayBsVsqiQ1d7rcu378azoFr3mpGfZBJs
 qSkwFyyn9qbdSaEXZOkciDLedA68WKcHaNA7jGc9PCgFilpD9G/8hXc/IDlH00E8oNPW
 eKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=MG3QiDYwnYyRJX/WbpqNA8DU22zfZF7tRC7pS5LrDa0=;
 fh=a2sNCG01Qj4Cnjs/1Xa7TE+P9wFJWjng52pFYO+JsoM=;
 b=O49tMlSaoYNYED5leL8UdWu5qotXsdht8k4U2vIs48E8ixA/ASJtrsQ2zdvUSgK9hZ
 tBLglTMGBvjFqt7Iz/Us8BwJxI2O5zO/Qew39sr6t18siuYplHhpwlNtGOmEzS4fafqX
 iK6dP6UeYslKRJzIfe4P3Nr1Skl8XssxCOKJrn+iefVVfz1Aclnj8UXyoN3dgg44FMfI
 7SSn5055Gikz92rLiz4VvI61TgORUKM59xec2V2zVM/Ld6YkZrKgyzaZnrM14DSZj0SX
 KsjfDBAfRKV5Sbip9hORyX+t6sVcFgU+uHGxX2cy5vH1Q/zsdwl2mqY/fodTYvrWoNdh
 2IAg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788393121; x=1788997921; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MG3QiDYwnYyRJX/WbpqNA8DU22zfZF7tRC7pS5LrDa0=;
 b=obOJt6FvYETAzK+bXn6FNb2mldh1pcau7nr4YT9o7xYo3kTHyetKxAjWshbVM8d+KT
 lcztwh7Xk9f5yhWonxgip43hZabycALXoD+yy1bIOLtdYB2b+kGsSo2AMBntUrV3l4I/
 e7Sv+GgOf07q76udRGr4AaFcaX/pyXlmc9WjxodtSOlutcB2q3Irv6AjJ9bymb+/xCVs
 USaM37vglSvMl/ijGZHPq1I7sJHYgnLo6Au0RBff4HRd/XNC+MtdZw1Oovf0ubRzxv/Y
 sqq7wrnDHn5R/qgGGAAJnmuwebF/UlvosuaBEIP8TfijPa+W1RpYdyE+Z9pCzMdLtXWn
 Rotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788393121; x=1788997921;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MG3QiDYwnYyRJX/WbpqNA8DU22zfZF7tRC7pS5LrDa0=;
 b=AyBLKtICk6N69lziEL4KYanoLG+KBxxjftF+SOJk5rdYWL4PvCSWixRNUZuMaMpecF
 B9HjoMRPZYB9zr8vnUChLPfTtN1H1faa9XVHF1V1LjymXsqlfcR2FZDuNDGNFQsZfReM
 gnUQvH4XUARRsELOk+bpHPBwHY1BxnqvatIBeKBR+4S31r49k1hxSrTIfiYUNM6YRpDn
 baUvnEy92NB6WD5cr0LoqHOK91XXBNL+lgtMBpMluqoTmt4+MgVfe2tJ2KXlmlrcq/n7
 dwRCvhBF1K3DfQS+6d5tgcLnTYAzkXydGZkmgnlyAYBW1j61Nbf+q+wbzMMlonkw1JMi
 hlAQ==
X-Gm-Message-State: AFuF++nCZGKwPHTwTcB3DzSRTuOJoaj9iGN9wLPYlFWRjCGq45FE6rwd
 2IGnmu/LNo/A+T3yTc+P3193DS39FydSOe2RY5AMJ1Q3jX9Yh8pC86eYmgG5/jxYIZFHiBqVBzy
 6NGgPjTgTwZ+i/nje/PrEZL8JyNhxAKA=
X-Gm-Gg: AYBFou1MMLGm0M6WOv6YQMDxmbfAy9L15jxu0FirsYBd4yFl89D2jFfgt9h8UIJ+tpW
 dz6j8ZOKGAnWG2Y+QidyVJwQ9dZPkRHAN2lBE63PvcmSo87+1K2nRlJJX5zzqZayVD1fZ78QJ2P
 yHJA1BuvMyzEBsCbogryl0mRAO4grpHq+y+GvVgps/+Jo1rOsJH8Q7s3WadVRUxh6DSTH7mmqNj
 1az+Xy4oz2q5/eXt/0hoegVelx16cG/Epq3HtvtNbXvTkOtpcMCvZUbxpy4g1QjYYPQkTlycSwe
 2RloHnJS/eu+7BwBbnMO6F0ay9d9Mo+nBGW2hG6SDhPonWt3VSHtHDW7ekgeqmDssdIz478IuWi
 A
X-Received: by 2002:a05:6402:371a:b0:6a5:f4eb:1085 with SMTP id
 4fb4d7f45d1cf-6a682aee057mr5780340a12.15.1788393121346; Wed, 02 Sep 2026
 16:52:01 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 16:52:00 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 16:52:00 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <a21bc0d17ce657d0ccd86fd398785b946fa268d6.1788213716.git.zhangxp1998@gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <a21bc0d17ce657d0ccd86fd398785b946fa268d6.1788213716.git.zhangxp1998@gmail.com>
Date: Wed, 2 Sep 2026 16:52:00 -0700
X-Gm-Features: AcwNN1X2wTr2PORB6BsTY-uCscv85cT3JQy32UzZoMMqaRMzmpuL9ftwzZj3Z6s
Message-ID: <CAH=xXfHZuQ2s1rQLdQ1tWSSVPTs9SX9GuNZ2kf3znjY2YyexPw@mail.gmail.com>
To: chao@kernel.org
X-Headers-End: 1x1ukS-0002mV-4u
Subject: Re: [f2fs-dev] [PATCH v7 06/11] f2fs: describe {i, d,
 id}node block layout dynamically
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

The 0-day build failure on feature/subpage (lkp report; 6/11,
include/linux/f2fs_fs.h:355: "expected specifier-qualifier-list before
'*' token") is a nested comment in struct f2fs_inode.

The applied commit keeps the old inline comment "/* direct(2)... node
id */" inside the new block comment, so the inner "*/" closes the comment
early and the following lines get parsed as struct members:

    /*
     * __le32 i_nid[DEF_NIDS_PER_INODE];  /* direct(2), indirect(2),
     *                  double_indirect(1) node id */
     *
     * It is stored immediately before the node footer ...
     */

That's a hard compile error on every arch, not just m68k-allmodconfig.

The version I posted in v7 6/11 doesn't have this; it drops the old
inline comment. The applied commit (35efac5) looks like an earlier
revision -- its subject is "{i, d, id}node" (with spaces) vs
"{i,d,id}node" in v7. Could you re-apply v7's 6/11, or de-nest the
comment, e.g.:

    /*
     * __le32 i_nid[DEF_NIDS_PER_INODE];
     * direct(2), indirect(2), double_indirect(1) node IDs
     *
     * It is stored immediately before the node footer at the end of
     * the filesystem block. Its offset depends on the filesystem block
     * size, so locate it dynamically with F2FS_INODE_NIDS().
     */

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
