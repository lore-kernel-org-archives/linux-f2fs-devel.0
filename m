Return-Path: <SRS0=Iz0M=76=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D718C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:33:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6C4206F1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YfFGWeMo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EUD0OIG+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="d+J+aw6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6C4206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chrisdown.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jlZ7e-00008D-TL; Wed, 17 Jun 2020 14:33:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chris@chrisdown.name>) id 1jlZ7d-000080-Ev
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 14:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=; b=YfFGWeMoSVlsgqazIh5JZEZzKL
 /7zpM8jeXE+biC3V7pXXGikaOF2DsrNO8GJWUnM/e+IF3RhJN6Jzab10lNMzJRxkhT7l9MGM6nMnJ
 Pvi44/s2a9VsU1eJU226Ugu4Z5343y1JMxk1EpmhWB6Sky7P5+xxyYsRjuJXn0RoUdXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=; b=EUD0OIG+/Sc1jMAene7j0xEt+b
 loF+nqIy32X5771c4NkdvR03aLLSfyyHCMF0d6yRRa8U2PeNRxGs/Q9OI6FnH5OCfoIbh9oeiWe+r
 WJ1brtrHtShmkPNeBA+S8JO1brEREBekDNEBaIH8g2yEbpaX9Fl7ueOdLAIOFHj9WDZo=;
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jlZ7Z-006zQo-Ve
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 14:33:01 +0000
Received: by mail-lj1-f193.google.com with SMTP id y11so3122551ljm.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2020 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chrisdown.name; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
 b=d+J+aw6Zm5XRvlxRf1UGsdkDdw/4mdWlAseuLVRmjuRl77imTs8xnEwfCx3+/GfmIn
 bikdBwRjyQV2FhPxZDoxaryjSxXvxqhpXbUEuGGRJ6XKTOw9aHhfZNDGhlxVfd4s8+dB
 zPJBHP+Y5JfMrXFtfl1BiiRwc2CLhSP1/aSVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
 b=QSTrpdp+bBaGZPzApepIxr4MbJZd7Y0fJUuayRs+tyqhKUAiyeGuVko97e9xkWkWYR
 RlB0eIcoCHxPNzDMv/KRgDakb/1PHk1vS0uEuvXq0ogKYqcQf/Vozb4Bm4KwImdJGdYa
 CcC3MyL5VTU535IuTYHeH6prpU7/qnzCQLWXo43TRn4YXdNU/G0P/btT99QSfGS9bd9o
 IRyCxfyZ1YiLuXg8+nUMhvZQ8fn6J2foRf4YeWTuW2qE3zSUH+8mc8gURfrlvDcCak6O
 kHQIEGitZc3KFA6q/nyy/SE++xrePoJufkikzgCguZBRvnirEerVRbA0CQ6gwl33+rWI
 Ly3g==
X-Gm-Message-State: AOAM530qzRwViD+yIrAgqe+sWGUaYF1fTxoTN3hf9vOQrKQ/9gEnDhBj
 QNspOklnItecf68MwUFTS7AuiwuOuW1SVx65
X-Google-Smtp-Source: ABdhPJzL0eIzzTI+SzZBoqt3/b7Xundx14ukkyOPthT2L2+/VFT7bPwecalJL/jau7TXAMBO1wA5IA==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr9338191wrs.226.1592402940724; 
 Wed, 17 Jun 2020 07:09:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
 by smtp.gmail.com with ESMTPSA id o6sm33035118wrp.3.2020.06.17.07.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:08:59 -0700 (PDT)
Date: Wed, 17 Jun 2020 15:08:59 +0100
From: Chris Down <chris@chrisdown.name>
To: Michal Hocko <mhocko@kernel.org>
Message-ID: <20200617140859.GB548179@chrisdown.name>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135951.GP9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617135951.GP9499@dhcp22.suse.cz>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Headers-End: 1jlZ7Z-006zQo-Ve
Subject: Re: [f2fs-dev] mm: mkfs.ext4 invoked oom-killer on i386 -
 pagecache_get_page
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
Cc: lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Yafang Shao <laoar.shao@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Cgroups <cgroups@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Michal Hocko writes:
>and it makes some sense. Except for the root memcg where we do not
>account any memory. Adding if (mem_cgroup_is_root(memcg)) return false;
>should do the trick. The same is the case for mem_cgroup_below_low.
>Could you give it a try please just to confirm?

Oh, of course :-) This seems more likely than what I proposed, and would be 
great to test.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
