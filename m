Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618E2FCD0CD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eclQx4zYDskGv7VCCkpZDjRwJfb4YThkfGAO4guU25I=; b=FVKyLBjUDJoMjZDk+l8h7G/Hgq
	ILgLe6AaCBFH3gBR0acY71bHwOpgcNXqwU3WDUtLZbfc5RNZD/EvRGKxV8t5D0KOcn015ZfWc9Jy3
	nubBNv8Z+fsax8tXyg/TQOaxbAkxYhQmzapiS8+0aBJI++WMAFVwywKJA4CAo9roPCh4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2lg1-0008Ce-1m;
	Wed, 18 Mar 2026 07:50:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1w2lfi-0008C9-5t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Mar 2026 07:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmYLNgJYtdAFrLTc6ctu9q3vMK2ZNSI++H84za9LNsE=; b=hOr/S2q3UFJgLkPbKEzGVOt+Tg
 wNibNkk3WFBZ7Z/C7gLyCeDAAsYQbmKh2I2Vz+wNWmhNTRZVi1zBdlgG6D8HacE9to0SRvqRzSi72
 eVoa5bNS6cv3I71lfiUB8Ocb3+Q5gIfx1wQgLkI1dfGAFwOa8ciJAdFdNNNCOAs7zaNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RmYLNgJYtdAFrLTc6ctu9q3vMK2ZNSI++H84za9LNsE=; b=VjSTIukclULUjq+yK1E+4I5bZE
 a0jGn+CytGWfFRBbhhKRL+7lfO5mkCJ5aUl8H7mlYpw/Q5pCuMY4HzG/XWlNCO3+K2DWt4gkWOJPF
 CB603S2CEt3onw+78iikUirG/HfRNNJ+I5WibMpFMgMURKancHjlly81Srt6E5lahQaY=;
Received: from mail-yw1-f175.google.com ([209.85.128.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w2lfh-0006SS-3y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Mar 2026 07:50:29 +0000
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7982c3b7da9so57646527b3.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Mar 2026 00:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773820218; cv=none;
 d=google.com; s=arc-20240605;
 b=gShWD4d0Pfub1Zl9abHWZExfRnW67c9MHQra8o2TJsFU5iQlo59jfEG/UrHtTtHhZH
 VyjF7HCkxVXJ0b5q+HjWV7AlwX2HQEey8ixXYaR5+WD0Ghrm27eMn92ol/FrHZ5xFugl
 dU5G5BXfdX1SGzkc+PyzRpoQvHrt0Wt5rbWmsfmpNoWakI/tSNS7G5iURBjEojzLVSVQ
 dmBfBWCxzSmJCjcUk0KIAFfRyMbIEqo1oFOxI7WB8KnL0EUS7cwCJUIlgki5fYA8uqPs
 yvm7AG62LshVGSuid+mLHoNWsGXlc7aa2IJgTv4l6QoXCTPkG5+Wpp9QBWbF1ksVCSTt
 lggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RmYLNgJYtdAFrLTc6ctu9q3vMK2ZNSI++H84za9LNsE=;
 fh=07Lu1bvpkHGboBy9jL2Xm9JyQGEyc50IpV+3DZXjCNg=;
 b=fsF2Vf6uQbPzP80YxY12G3MjLC3ev4HBaVyZWf9/7tTyf/+iV/CivjcDTlTi3Hh1yc
 JCio1nNt9D3HjACTSE1To2RQbvX1PNGaOyToifhxL8M9Hxp/8BmZKnULVInGB/kl7rl4
 3ChJ5p+aH/if4KkXz/oD3bzG8RPsGL+ZabTHcEnp7AKb/zPpC3HOrpvTkBGez7S2ipHd
 mwBO0Z0GJwskSOu0o7fnGWVAd24Ieh53JUeSmVBCeLfNltke/F03Qc3eUPaJlqSJFdR0
 j1uis13EuLyKb52a61Bezny2Rk1clPESQXpimaWWseGwD8Ov4SwQii9NftoqVbxYvlfQ
 jpwA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773820218; x=1774425018; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RmYLNgJYtdAFrLTc6ctu9q3vMK2ZNSI++H84za9LNsE=;
 b=GFkMyqaBqOfgeg3s866MJgR4RWtucVVSYsKahLDkJIJK1ZeouT6SAC9DlLlIgSGgcd
 8kIOnEfzITdZDWyYfHeDB1B+pskHnyCB0M+3mrtNybMDD/BCuChLiprBdFqADBC9TnHl
 Q0faW8mvrr7Lb1ygnbP5WluZjbU59UYhkBcaJ9yaRylulrDDOSPthNgR3S5uamIW6BT9
 4nVAvJhBMo4WHBQ3awjoMIpWeRyiCheX1NaQf5CGdY7BiPV/cvTGyTO5qbknAss6o+Fp
 cNJ7vpVqJrJRSrWhXHoce8Bcp7TnOZhdnSZeCzzZG89gZOD93Z9Up79rPq0U2xRXL50j
 OQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773820218; x=1774425018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmYLNgJYtdAFrLTc6ctu9q3vMK2ZNSI++H84za9LNsE=;
 b=VhpKeOk6wBw8OygNEG/R4a3W04cc48aeM+rEaRC0oI4pqXGebKan7aRo2XP9tUeNlw
 tzl/2gvIAa5XjhMe1XczftHBfe2ExsYSdMU3GjkStS818n864Nxt/Fg+JsoPIo56GOfo
 n+2sJSUUXGmwvTHlg8nWvgBOD5ZhxZmn9RHtuOhvFy9UpxZzfHmyviUB1emvpbjYToaM
 xfrAZhpm8f6RHjV5ULn22LIqW/BwQRv8wlWHQag9C2asGcWQZC1mitbQyxgCtCVD1fKm
 yvCapPo54zzyLi+IPMpwhXdW0ihBzQxtOVpwOedXeKuKSxnbc/p9YRbhd7eiNisv+Cb6
 FP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfj1FE+c4Je+xcQJljO8quQv59Z9k3WyRr32OMxzCuXIdhxlYHAVhY6ba1XwCZKH7LNNpq3pLcPFzUOAlfiAfu@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyg75SGCQZlbq7xL7ntextJezQJt3oDEGUGnbUvvjfbwOJLeVDK
 rnyrLdxLMFHsdQfR2TL6cDmhaXqJPZfQWu3gNxG7JbmwoVP1PEaFW2JOiWTC/ig3BgmRXopGZ/d
 UgPb+Qp74fzdEh9E/XVXSDllXqY2eMFur1IElDY/9u7EB
X-Gm-Gg: ATEYQzwZaipKDwo9RoP/vXhTW3nd/kikuBreVIIS+ZwhCc6aX7F4vcQVzJyzZhjZE3y
 AeGa6wCdy4xU+lZ7cNXU/zYp5aKzI+i+7LUnRniaJtxWETNwiPICPgU6mcgnxOvY86C0daoa1gz
 CToTjHDRGytUgyXu18ejbeawrHtbdb2cBIUd9iYs215KqtS5xNhRBmoNXTeg4Wwl98J4c/sPELw
 5AB+O2/pLDLJa7HOukYcgQ0HLqag7HY5Nzm4UoLWLb8xAyiTfmodqG833hQlZOseNO9oLTxK0JE
 IqTB/QE=
X-Received: by 2002:a05:690c:e:b0:798:5333:ce1c with SMTP id
 00721157ae682-79a718af029mr23896987b3.23.1773820218288; Wed, 18 Mar 2026
 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260317114225.3017089-1-zzzccc427@gmail.com>
 <e4c34148-e667-4e36-a1cf-57aaada22dd9@kernel.org>
In-Reply-To: <e4c34148-e667-4e36-a1cf-57aaada22dd9@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 18 Mar 2026 15:50:04 +0800
X-Gm-Features: AaiRm50Ox0URrb9myvi4BfSdFZ9YPWVBXRyXr8QYABiQyqk7G3Nsna-5_o46h-s
Message-ID: <CAFRLqsXz5-5Mrsh3VEJxVAcYVTg49EdvUa1TQq61Z4cuC9zF1Q@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1w2lfh-0006SS-3y
Subject: Re: [f2fs-dev] [PATCH] f2fs: add READ_ONCE() for i_blocks in
 f2fs_update_inode()
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
Cc: gality369@gmail.com, zhenghaoran154@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 ziyuzhang201@gmail.com, r33s3n6@gmail.com, jaegeuk@kernel.org,
 hanguidong02@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Thank you for the review.

On 2026/3/18 13:56, Chao Yu wrote:
> Need a Fixes line and Cc stable@kernel.org?

Good point, added both in v2:

  Fixes: 19f99cee206c ("f2fs: add core inode operations")
  Cc: stable@vger.kernel.org

> Otherwise, it looks good to me.

Thanks!

Best regards,
Cen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
