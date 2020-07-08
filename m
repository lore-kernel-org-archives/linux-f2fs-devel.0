Return-Path: <SRS0=VsZi=AT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E8C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:45:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D543B221EE;
	Wed,  8 Jul 2020 08:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NEsNmo5R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lzZzqLpV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mirlab-org.20150623.gappssmtp.com header.i=@mirlab-org.20150623.gappssmtp.com header.b="ksRzk0b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D543B221EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirlab.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jt5hd-00046R-Ft; Wed, 08 Jul 2020 08:45:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pahome.chen@mirlab.org>) id 1jt5hc-00045e-1P
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 08:45:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lMu+aG/s9F9vpHhRbiTe3DbDn6qr2dStqd3ndV5QL3k=; b=NEsNmo5RCMyIVAOzmGJwFLOoBq
 KkGN9Y6NoXOle15pPsYBAr4pilByymycvfJ9zxKpCBA1qP2NRNDABdg6gOWyHH/Hu65dv3isIBPeF
 9tc0s3B0A2T+hDKHuFq69wW14GQdIYBsM1WmAnWEqBwZ1P/WHzkIZ/VVxEl4I4uC+e00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lMu+aG/s9F9vpHhRbiTe3DbDn6qr2dStqd3ndV5QL3k=; b=l
 zZzqLpVfaAocq39iOg0QJGLB5BxFQuflA/g/rkiDYI46uBaIHtfgXHWDr07RtphYxDdTjS+UJ9hus
 RlCp8I5Y1SSCDI4h9YziCt5BNS8f8jw61TdLLuEYZ6kzHlWiDB1Ux0ImR02BnfZ50i/ZdrFjXEv8X
 +JBf786EzQb541nY=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jt5hX-00B05U-Gk
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 08:45:15 +0000
Received: by mail-ej1-f41.google.com with SMTP id w16so49471135ejj.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2020 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mirlab-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=lMu+aG/s9F9vpHhRbiTe3DbDn6qr2dStqd3ndV5QL3k=;
 b=ksRzk0b4g0Hkw1xgF1u9xWoKYdx0W51Lx9Ab+0zjHH23G1wDvmdSvzvcGtgS6b6FuS
 YLGOPg7jJIk25lp1g2L2cIKWOjiAkg7InTAmm3JquYhcYen09bAmh76mjI1f0ZMsriYK
 FSYXhhidK9X/qA6khTPQnxNiwEpCtTV2CSHI8Hk/MaRGnbHfsf/YUrlSIVJKgRuLagq0
 EfrnDIN5m2QePH8Mg6qCQyedqftbv3DSKNyzQf+UQHGMVsIm2PeO5qAdBWHqcaoqfKxR
 gczkaUluCEj/b7d8ke+Cx04niILkw3/OeuNeq//146MkpCY897C+Zniy9Vv35a0306Cy
 F11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=lMu+aG/s9F9vpHhRbiTe3DbDn6qr2dStqd3ndV5QL3k=;
 b=TXlHQXQBJBK2IvredUDwj9N8ooC+bzOb5OU5NcEF535aOnCgFp3/i8NfJSvVb+QVVA
 dEqHsk0nJw2ISHxtlqTFEP7qgu3K484LVqqiEIo6Oovg+SHmU9KxJTwYa0RAhORtyrc/
 rUR51MxnjkPE5au1mUMejdIXRVHo0mlIc8dvKl0Up7nH63w2Ss1zfC/Ym+KPZhgQ6L8p
 8NcJbrt+6Yz+C3L+YeI/BUcppAWac0/ofLf9pNtFgk7tfs18vxm+DY4fkKZ1aGpVC+QC
 PczCQOsWFJEOPnxCQbXFVcWvsDEu8eYx7ujM6H/N60Cn7I/sRXO1N+cRz7j0J7mjtVUQ
 c8cA==
X-Gm-Message-State: AOAM531Ono5HwdyhF5JG7zJhMarwEXfs/9bH+zcmMv8eQ/SjMQu6mgcc
 AzRK5WyOpIGW+TwxZJEz7BtMfLeA95e3BHF++qYWyX04oLU=
X-Google-Smtp-Source: ABdhPJxxV/D+V8ykUZ++3ZvTCZEFZALcoiO0GBr0U+dWxpCh/vMhlEth1XjpbZK5axNKYoujm4EIwUfiaeOmMHXWf4E=
X-Received: by 2002:a17:906:f88a:: with SMTP id
 lg10mr49828639ejb.317.1594197904784; 
 Wed, 08 Jul 2020 01:45:04 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Wed, 8 Jul 2020 16:44:53 +0800
Message-ID: <CAB3eZfvtOZygwN-m_DUmJroyk2sP=ukLGKneHhseX6Ajcub-dw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1jt5hX-00B05U-Gk
Subject: [f2fs-dev] Will Hot data and Warm data and Cold data in same
 segment?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

One segment will contain many blocks, node and data will not be the
same segment.

Take data block for example, Will Hot data and Warm data and Cold data
in same segment?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
