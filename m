Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9711F9D0D1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Liu1TvoAORhWGO5bnLbUlHjzAIb5F7Spk0X5OP41xmc=; b=bGLyxP/uP7qkSOxDF90VvSWhdk
	R90r68GoOdOo/9krrsEvmyKB+JMQuGtLtafha+dVE4AGqWCe0ONZtKtMLfGMkX65BH7cEEe+6o+wH
	LAr97LuHJlxuPok5opoS69wXJiDeR9brzNXr+f52gpgwfhNN7X01fvwxMhuEk9etKMBY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCeDY-0000He-DB;
	Tue, 14 Apr 2026 13:54:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wCeDC-0000H1-Qv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 13:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YY1Mbdcw/s+c+i+V6kA9q5Q93RsUlrrtxkE/+YiJlwM=; b=JMIrB0q+qrPiOKOTo7/VKlySVN
 zCvJEvuPS5umVTyB6bMF9OXWPvAdkjL287ty1b918mGe6VLGxkiNJJYIkFa11ldE9KbUTrqZfQ+Jh
 9qDpfF4qXdnycXAaQQ2OJRRFwZn+1T3fUyXhs9uQUELH6OEr2d0vFFn0j/vDXdTO9CAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YY1Mbdcw/s+c+i+V6kA9q5Q93RsUlrrtxkE/+YiJlwM=; b=KWO5ATDPvbP10+Y0npDcgYqDCC
 SMBP+9jdNtimb3eFii2DOnZ9xtXELDWJeUu+g5QhbPXL/3P976PEg3PbQGhNvq034LF2DPPgcRyr6
 dZ5ptM93HW2lnjJJ+J3tEYqKlmQFJn6itNDZeYqvgQESgr3KyXpkg/fWAf0RhxrljUyI=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCeDC-0002VI-Ec for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 13:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776174823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YY1Mbdcw/s+c+i+V6kA9q5Q93RsUlrrtxkE/+YiJlwM=;
 b=YoqLi3UmcKrONhVx9Ed59cshycgid4CigMjRDl5qK1NI04kszcB9WsD6OdOHZTYqvk0QR5
 EfG/V7ZpkIEepLZZhStoaoNA0LgZGdUbqlif1KRg/bhJB2ruRgjwiy1BeXOsxQaQDuVIp8
 3Eaw83ON6YzqbmJvZiveJTp6o1dEPsY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-YECHS7BIOsaKeCl818nJdA-1; Tue, 14 Apr 2026 09:53:40 -0400
X-MC-Unique: YECHS7BIOsaKeCl818nJdA-1
X-Mimecast-MFC-AGG-ID: YECHS7BIOsaKeCl818nJdA_1776174819
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d9e1e61aso27257295e9.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Apr 2026 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174819; x=1776779619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY1Mbdcw/s+c+i+V6kA9q5Q93RsUlrrtxkE/+YiJlwM=;
 b=OBqMIrI1pXVBjQnxxt+td+1SJjEknNKhJA1DpaekSBVF0hbNS2BU+sX1Sq8yhdbZyD
 02E9Ujr5jsQ2AWoMCL7F5Tlt9BQEZbCWRCykBFRUd06EAnlbuexMpQk72dKBIAnu8mag
 jw/vY9ZZ8mQ5r4OyyQiPMiLQVpI661ZYk/ChfddV3MQTAf6T/2/3mRfDbzOV2GD5dEyz
 yL4gtWo9lpf327r5XVK9vgf/x36LhJw0cvVLngskD+rxtIdVTkPu0HLI3tmGP3oId579
 5gxVKhxgLiW1K/TkhwNWWfgPBW/65THTmfEU6uEIT3xTUKGzbMh/wQ5Q7NantBFPWjQP
 JYdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fDbiAw8HZHRx1sFXuUwdml5FDnAMrhWlHb3skvnnPNeeI/KTj7tYt7WD19wKT3AXVQpvIRTp+DiwtrpaaxfQj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyDefUTLTWvYYS45bq557UKIRE4VzjLNm8jo/rj7vY1UDYcru7c
 g5t/XEevi8uoh57Nl8p5rd21qUxQj3mLRZfxkRei0l7/N/DxjvewHJBNVf6vSrc792pfWPB6TnO
 vNMM77dZQ/joimf4MBKeskem2y9wrcS4koRndvu/ap7hx+qv35p5ts9AaYWg5aeE7pN1I/koG2f
 IRYQ==
X-Gm-Gg: AeBDieviKfmm1mL+axQJw8H6DuiB/VkH+fgPKaFVOI0rMZo6imTjTMFcK1ivujb9EVg
 kxaotBy9nZeaUm531/gXvQhNhQnhmh4SL8gWBiODgQ/wq0oCUjIOElyTX5Fi4fBUmF0TJnDy0FQ
 mCVBm86FEQpfuzIro/DJqFxIDmT9r5Fc/LbJdgZCtMfj/c+BLxtlXN0x7NER+mxhOTEpFhevzp/
 DU2FCGYv338li5imrT8YczDJPh25RtTDmndNLa4klgOdvmAgs4FimR5mjJV7YDENrHddI0lNWdq
 TokCI0N0Y7n7D4EoByeOjUTmHN7yVqWxnIfpbsaa9n97L8gMOs9/Zc/tB0uRlloP4ROQJrY+jpw
 inizh5Duqm6fY2w==
X-Received: by 2002:a05:600c:a109:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-488d6843245mr171916545e9.16.1776174818764; 
 Tue, 14 Apr 2026 06:53:38 -0700 (PDT)
X-Received: by 2002:a05:600c:a109:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-488d6843245mr171916275e9.16.1776174818293; 
 Tue, 14 Apr 2026 06:53:38 -0700 (PDT)
Received: from thinky ([91.245.205.131]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5cfeb2dsm124119015e9.0.2026.04.14.06.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 06:53:37 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:53:36 +0200
To: Christoph Hellwig <hch@lst.de>
Message-ID: <u3szxuhjrv7vyxwyrepuflwhzeucss7xj3cxj73mnpm5kal2da@jck24ig4oxxa>
References: <20260409131404.1545834-1-aalbersh@kernel.org>
 <20260409131404.1545834-4-aalbersh@kernel.org>
 <20260414081301.GB11138@lst.de>
MIME-Version: 1.0
In-Reply-To: <20260414081301.GB11138@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BKVgOBY55ynsFbfuHsV7QDEPaoGmg3FSO5z483Xv-5E_1776174819
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wCeDC-0002VI-Ec
Subject: Re: [f2fs-dev] [PATCH v7 03/22] ovl: use core fsverity ensure info
 interface
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-04-14 10:13:01, Christoph Hellwig wrote:
> On Thu, Apr 09, 2026 at 03:13:35PM +0200, Andrey Albershteyn wrote:
> > -	if (!fsverity_active(inode) && IS_VERITY(inode)) {
> > -		/*
> > -		 * If this inode was not yet opened, the verity info hasn't been
> > -		 * loaded yet, so we need to do that here to force it into memory.
> > -		 */
> > -		filp = kernel_file_open(datapath, O_RDONLY, current_cred());
> > -		if (IS_ERR(filp))
> > -			return PTR_ERR(filp);
> > -		fput(filp);
> > -	}
> > +	if (fsverity_active(inode))
> > +		fsverity_ensure_verity_info(inode);
> 
> fsverity_ensure_verity_info already is a no-op for !fsverity_active,
> so the check could be remove.

I don't think it is. For non-fsverity inodes it will try to call into
descriptor reading callback and fail.

> Also we should probably propagate the
> error return from fsverity_ensure_verity_info here.

oh right, thanks!

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
