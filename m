Return-Path: <SRS0=DrP0=44=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5417C0044D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:46:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C01B20734;
	Wed, 11 Mar 2020 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WBSlOH3i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dOqO9UT6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SniYRJq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C01B20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jC5RL-0007ir-7p; Wed, 11 Mar 2020 17:46:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <torvalds@linuxfoundation.org>) id 1jC5RJ-0007id-Ak
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 17:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=; b=WBSlOH3ieeMLNiNkLzdHHHnzaF
 EOfJsL5X3aQwDWEreTywliWQSan/vXujrlEEt0jrs+g7sOV9gE7t6/jYy0oShmdtgh8ppZKi+wcq+
 M3lmS31u4fndTY1EO6wW1qvqjaeXti7QWawWrCkA7b3femmg8nCZhlO9Oq4s6q0GH2P8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=; b=dOqO9UT6KxQ2ykltKvB2V/FZA1
 n2Q4AYPKCeSyELTLyA3xL9WSa8B5q4CRV9+nRvnz5DHm2qQ7ouNZt9uolU50sNWirpzY5/fvTV81U
 dYwKkq8jBlzp0rcdCKzHli55oVZibQkGqGsyLXTA/ghUosKMJb3rT1kj6iPmrhuXdR5Q=;
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jC5RD-008cV9-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 17:46:41 +0000
Received: by mail-ed1-f66.google.com with SMTP id ca19so3881544edb.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2020 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=;
 b=SniYRJq8qrMWk118P05M9PetiYL7ODjNp75BvsOcDJIlqRkPD3Jb97yILnYQFVOz3/
 kiJlYw0cMZBed9vrOZnFV+UZBXXysRi52+PxPI+rg/qM/xWIbOjLpjK7O1VzB68ts7iY
 82PbMl8MtY1FZuEId9Eyj3WPq1fryqn0sIQrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=;
 b=tsUDBTeIUzhuoxPcp0fuQL9sZ9QzSmAQtKWUUKpBj9hKyiq3hgBN8UJ6hzri6RerNQ
 22AYQi/ralrUfHyZqG43PAS0qbDx6RzvafxUpslIJygGPWhFu/Q7WIC6TA5T92OIurwv
 pHBUTjDdL39hOb7XtAeFaRkLNjmvd5pgaVGz9QqJmfeQDLRy+zVbSwJzFI/El+c8vS5/
 TVhX3YwPHa7f4WUyS4fGaNDHIO6IkLteR9ulnkpVGq7/3Be5LLhSbgkVaGAj2cy/p9mz
 5kwLW1yibBkrSxstDsyrkWH+JPjMxDwDvow3kAhN/nNzOAdqbxx1TEiuytZ40DBhx5Mw
 6T8Q==
X-Gm-Message-State: ANhLgQ0mhzsoMsvh8uWVXTMd2NbuJCCXK1v/QCHzRt0G4WMD/Y4aZuq/
 RpOzvRlnkGHydiea6CmXQqVu5tsg2Ew=
X-Google-Smtp-Source: ADFU+vv3MdzqkgGsPq95XI8vyBSx93spCkr7jFNqYPR22PbwcvZFfPRvPVCN3CDZCp94oeLTFlDQIA==
X-Received: by 2002:a19:6513:: with SMTP id z19mr2781307lfb.207.1583947257724; 
 Wed, 11 Mar 2020 10:20:57 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46])
 by smtp.gmail.com with ESMTPSA id u21sm6722207ljo.4.2020.03.11.10.20.56
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:20:57 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id b186so2312059lfg.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2020 10:20:56 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id
 k15mr2864358lfg.142.1583947256468; 
 Wed, 11 Mar 2020 10:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200311162735.GA152176@google.com>
In-Reply-To: <20200311162735.GA152176@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Mar 2020 10:20:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
Message-ID: <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1jC5RD-008cV9-Fb
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.6-rc6
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 11, 2020 at 9:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Sorry for late pull request. Could you please consider this?

I pulled this, and then immediately unpulled.

Most (all?) of the commits have been committed basically minutes
before you sent the pull request.

That's simply not acceptable. Not when we're in late rc, and with
hundreds of lines of changes, and when there is no explanation for a
late pull request that was very very recently generated.

                Linus


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
