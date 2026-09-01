Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6FC624D5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6jx16YM4VNYSbanNMaD7jgZF4j8FnY5fUyvs0+tMOM=; b=T/e0p78dYo38IAfeJwk+OMY6Yz
	w6G4VLFX8xgTGv2MNFYhJZPtbPCTBkePuzEfh+ampyEUrboO8zZblGA3SKfcyGfEaiE5rib1vm6tF
	dFb0lcKYEL1LoWH6+uW3EGysm660aRN8nDe1Sk6EC8Smo303dLcQyd/T0t94xdOK1Eeo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RV9-0003Us-7n;
	Tue, 01 Sep 2026 16:38:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RV8-0003Uj-3F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5rJhWWYW+3DExYvc55pg6QlitpW2bU5Ma2FTann+ec=; b=edykhVABDu/SDlCMR4iD1jWYr9
 KyvoRYWN+bkn3okyNpDmlev4xKE1JeENUuiild2VapYzNanVWk+MuWw1dp8sbDSKw86Sg4n+92i7U
 o6IKW+2lVwvzhQxJGg7st9uEAjS1ntyXJsNq0LUkJfmowoL/YJD1YxrzusnFoLYtOWBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E5rJhWWYW+3DExYvc55pg6QlitpW2bU5Ma2FTann+ec=; b=dtw8o9+0s3kNafdKNMj6qNtkr/
 Nb6zCD9bVLWPzOHZugCjcg6IimtiuhFzDOv8vEJKettsMYmJoZ8pXnDrjAdSm8tbk8fcxHwNzM6Z5
 9EZn43zf9+myLrmhagREYfJ55NpHxfwg/gVXOXWuaaXlrkw0y3EU6y8J8XHkdrZk+liA=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RV7-00062z-Cc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:22 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a6108734d5so14426a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280695; cv=none;
 d=google.com; s=arc-20260327;
 b=ekmeEgr3cAT9l0fINYPWjJjI98BvNE8rhoBsye3qpbevyw2nc6uuI4nHQ9OvDaInEg
 S7rDpQAJcMIk2zyesuvVPS0bgZdjke8Qsg8FglUL2BuyMtpqlp3yKVt0FFdE+GPwU6dk
 /8jOBrFMHh9zs3HH5ZIbfui/7MZObiYa29YpdU2AOl4wyBI+7SxLhFWdtVfZGIQoLlWR
 AAnYhkaM9o3f5kyF6wXUD2At4PJ2EwONDPgndcB9gS0PM/ZpO+a3hbDw/Iamsyr8KgKH
 eId07mP/NGQk19DnB7kXKtqsUEAIRoO7UFQYHYtMRpjHpgP5LDglJcJl6ijlLofazCY8
 uH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=E5rJhWWYW+3DExYvc55pg6QlitpW2bU5Ma2FTann+ec=;
 fh=jtMVZwNvdQasxd3fk2IOdCUROR7CYg4usFXgN3wmJew=;
 b=YL1DmX9Gw/Fk4rCxooUBlmR6U2AOU3z8GWvRJhavKivJil6RlieU2XE2XO8/iN/w/2
 oAf+xiiqsl0slEvql9hyOSJcJEuou7HGewvsCkkdvLpoSxJ7EAWYJhj09VXtN+yy6oHa
 vvr9FRisOIz+/X4oNEQ940ShNaof0vA5sCO2cGiPdD9HMG8kVHBNdfm3ecjZANJcWWSs
 b2Rou0qEi9Ktz2tNQRGGWH7RLy1mJBda4jaC/pmXn/2N0+XyQdlUP+E7QAftMlv220kz
 G+RcCyu8nvYlYm7wl1ysuDxijElDeDVG8Vo0YBmA+lddLOlV0ar507V8sE8JAS585v9D
 dvnw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280695; x=1788885495; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E5rJhWWYW+3DExYvc55pg6QlitpW2bU5Ma2FTann+ec=;
 b=lHyORpDznySAWQzq+eZrWGnfdIK/caWs9aTXIIjBETYQ6yfAluDciRkZq15qmqUVpW
 eVomXjuMBSBGBlne89O02E0q5YjkzxZGiywTflRDiz4YZjmw7YT2EFo+W1zhmwx1QnVF
 /I+3paYCIbsf7B/w9ujrJwTCjjvIfta1MwrgOeJDJu75hiCg/GILCF8KurzEXr4CZJVS
 C7ZZRPyEnLkmyX9b5OBlTvlTGpeKGflyifVADSpWR0BmA/CmMG2+Qq9cX9pmsaEwSINm
 X4PosOihym5I1rNoIJaWHltopbAswgoAo/8LQFRUFzGApzWpKjQefusUiBJz/eThdCsi
 kRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280695; x=1788885495;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E5rJhWWYW+3DExYvc55pg6QlitpW2bU5Ma2FTann+ec=;
 b=purAqYOyZXCTWv2YY8gYYBP/7HkW8aTz+Y8Xb65Hohkm82NK3bCfJzreYHejssaDV7
 HC6xBIPcqErrpVrDsrHRTs/xZuKCG197KxCBRo9FHa1AFHa9CGPOcGWrHcMaO5xxTvyG
 H0xfMU5EmhlfqJkozguvRj2XUjAcVYNjs6BS+Tt+lsu14u/xj7UAL79W6fQtlY/Tq6xF
 bGlkzN2KAGetq6Y7PtI8bIh0Egrm8g68gZTE1eEvvWyQh1qqPA/VwGNE0See9BzMPQXL
 jpSe5fA7ybyuEDvlZhAW1siBbYBAop84m5q07L9eOiMz/8QERjDhLAGtt8dNAsJMP9VT
 8pTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdECjhgfhWHevZlHJ5jgx629bYDIYG30C9f6ft/+6jVoLMlyc+MJ4A5HuVZNPG5wJpfdK5CUSdnXGVffVLEE5Z@lists.sourceforge.net
X-Gm-Message-State: AFuF++nhd6vKp/GJqmE3okAdB8EFSj9BhcEN5iU60+MaTlc6SKLXpUOU
 qpoUN8aGu1Sd2lckKAz35U/GVBoVq+g8csGVFFmVLLFNini3lEvCttGfAYu5l0MCBzC5NMcfz7V
 zyuxHp1PQwe8nsjJbsTbxwnKy3NnwL1M=
X-Gm-Gg: AYBFou17n8yEbi96zMRxSLhq0D0qAiYHwjHCOTvlFVweX9v4yvGr8vVVLglrp91Nt6D
 yQfITVNT+vyIrcI9sGV/oj3tV5EurQ/wCyLRoVdC6vPOG6LFRTL4GYNd6WL3Tj+n6nrqGEblLgg
 x7vj5q42gyM98zq3mrADQpXhAs+9f31yrjsLJ82Oz1Y74/LCFAt/meL/3R21FR77JHMxVZP0u3P
 exfTiGUsTF8vf4Z02Tm2XRC+h0eYUS9PIC8kKiPHOZq8MZGqWQt9rGaEi4BSawVFA7CJ/W3C1El
 RVAgxifeYZWOfImlFv6X5kvi8baaSYsnWm0DZ5Bm3rUMpD4lQSbzPU/RzwETH08rCs+39UBcLWe
 cOhr12jmmSFaT
X-Received: by 2002:a05:6402:52c5:b0:6a0:9776:cb5b with SMTP id
 4fb4d7f45d1cf-6a663ab82bcmr7333920a12.13.1788280694622; Tue, 01 Sep 2026
 09:38:14 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:13 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:13 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <63f1e1ae-444f-406f-b76d-312cd0b76bdb@kernel.org>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <a21bc0d17ce657d0ccd86fd398785b946fa268d6.1788213716.git.zhangxp1998@gmail.com>
 <63f1e1ae-444f-406f-b76d-312cd0b76bdb@kernel.org>
Date: Tue, 1 Sep 2026 11:38:13 -0500
X-Gm-Features: AcwNN1Wdz9amKGmpbEpp8kdOK6krmeggFrDAetBFf9ciHhRr8poaSQG8EaTT7qE
Message-ID: <CAH=xXfG+djih687sXuzBD=0nP-hndziUgn5LU8_Vzu+SZoTHRQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x1RV7-00062z-Cc
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks. I have moved F2FS_MAX_BLKSIZE to the xattr patch where it is
first used, and restored the direct(2), indirect(2),
double_indirect(1) node IDs comment.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
