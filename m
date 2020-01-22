Return-Path: <SRS0=ZV1O=3L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC2AC2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:16:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FC224656;
	Wed, 22 Jan 2020 01:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="deNtBJM7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KwwGUKpQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="G9K/qW1c";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="sbjgI932"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FC224656
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDgqvs8k4xRlcM12RAK0XnUjVINBOShi3TxzT09Jq80=; b=deNtBJM72r0ht1bKC8DQ8FlB8j
	0zUDKWgWAnSkB7+lsF/+sgjDSxbN8HUrbP0wi5a5uSzB4ngbrq4/wo8nCrBnVlLKcOINBghHosejK
	7PvXFKqWEHU4Y+8EpgjXY6FBBp0xeJnQEaK2tM+tEr1cNRkF+eYjoSltSJqVzbKRqPbg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iu4de-0005Ty-6A; Wed, 22 Jan 2020 01:16:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1iu4dc-0005Tr-Hw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jan 2020 01:16:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=; b=KwwGUKpQ3zomLHW4PQa3lBbENz
 qH6CT9zY7mfjU6Zw4Vm0K8jydXxdIutHdMY20dc9kMnFnRFmx+UTL/jOt0WSyC5zCMABfB6GYs/Cu
 h3wQmL2RnpM7esiNHGsPk8RvIZix+qR8SiN/WbXt1dZpnGmk1QyQwe5Qe3/uDchvibUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=; b=G9K/qW1cdaSVC6JEHdDarxTpQY
 AcGEbKN1ahwBLbiklfswjh46QbQbjpkipOHfr+XKrGr9ItGmLxKlQ/Y+w9aZrJ+UAabC/rAJIXzyn
 Vewj0WzSVHwNqk0kH0gXGlOR4MJCB3RtuCc8upGOOY0/+BZ0xzf2VszMr/uTpQOTh8c4=;
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iu4da-00H5L5-Am
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jan 2020 01:16:56 +0000
Received: by mail-lj1-f196.google.com with SMTP id y6so4927759lji.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 Jan 2020 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=;
 b=sbjgI932IVsBnwvZcFBnekfHjH6LPvKho84iI0IqHn/lre/vnHDKZVHxM1chNODhEO
 oeBlWCXMu1xE41wCdmoAkJJWr3Xo/D+ju9vZ24VZpOnhSgfRdcQ5am2PHHrxTnbqi0XX
 b6eAwer8WCvSMIGV6+9Wm90f1KZ3856dgqPB2hB+SbeEq0VAirrYLusuJK6x9OvIXK1e
 QDAc9rab8nWgGfMDGKUKmikIqpQ1Tb6qVVp8u1rUGV3i6DXFmO0XieZmSerhbsGxj1Kd
 Nom76vDbxrBnAL633zaFY9rrVrFB9Ton5m1jJHrUpOo8xzUYC7WMuWNZ+fTJ5iMxzctH
 wfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=;
 b=AkJelnDicGjJK23r2upVDPTHKYs1lU2X02g4/MBbk6FacdCothVaB18z0bp0EGJcUH
 ZE5pZ2XUP0HpKAkEYJr55TBBNzNlqeQdCV+CbR/krkLc/gtlGcZy1y9cvFliKol8a00h
 J2KIMCZ2dJK7S8atQRzKuYbyxY8b42+rqGviiTkc7PKuXUbq4sBY2PJEv16rv2J3YQET
 unWPuMBh8iRxt5Zgn5tAjis1Prt+r+xyV8XJpr6C9F39uOLP2vdraMSifOoQodbPyB8g
 L+t+HNR2Jb9TI90aS/XOAR6P78yfb/zidgdBq1G1lZKWsDnhJERjf8GA2B1UCORdVwsK
 KGNw==
X-Gm-Message-State: APjAAAVcMrVFBIv9mZv07zXIg86DYznQv5XZ50SR7zWL046OTcA8X156
 NQOqEZubt6EZGWI4VhmwkVwYJtqIHaJ2s2zTM1wXCQ==
X-Google-Smtp-Source: APXvYqx9Wcig2VJsMhSPvoP5661qvRVt8CMWdEp0WvbCQ34genipkG1eA/ei4esFDAtnsgj2YEIbFdJHl+MGczi/Wzs=
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr18133901ljm.155.1579655807322; 
 Tue, 21 Jan 2020 17:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120223201.241390-1-ebiggers@kernel.org>
 <20200120223201.241390-4-ebiggers@kernel.org>
In-Reply-To: <20200120223201.241390-4-ebiggers@kernel.org>
Date: Tue, 21 Jan 2020 17:16:36 -0800
Message-ID: <CA+PiJmT1GPgLBYak51V04jtyDjOFPzSeaTxKryCqy3Ak6yAo6A@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1iu4da-00H5L5-Am
Subject: Re: [f2fs-dev] [PATCH v5 3/6] fscrypt: clarify what is meant by a
 per-file key
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 20, 2020 at 2:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that there's sometimes a second type of per-file key (the dirhash
> key), clarify some function names, macros, and documentation that
> specifically deal with per-file *encryption* keys.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add
Reviewed-by: Daniel Rosenberg <drosen@google>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
