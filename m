Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB26C47089
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Dec 2022 20:34:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p2IAu-0001k5-Sj;
	Mon, 05 Dec 2022 20:34:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1p2IAt-0001js-JI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Dec 2022 20:34:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=; b=IJq3QghBlAMObq6Mw7afYhOuOo
 GoaVP4aSgQ/Y3V9O8KriUdUk2SbTYYZo7I6URzHrsCxQWAIDSOjMWzY6YyQ4MAdXu9pIL4ZWhDN1M
 /bBGvPc4hW/E6xzH15xqRTwLNl07XcJOw7V6yUTfD3Ypach+pvR71InKAU5ulSedMlyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=; b=chVYeylAALf/084pYgS3BEIizT
 LDyO0xEpabdmQ4I2rH1DfYVKxQclE4znT2PTq2d3z44r2POuM1P5NgvisGpEkJ0hvFqZYGLW6ZWkf
 r7uMIw57NB0EKFWalPcG3rySFyUZ99hWYXP1eJuy7Qd/8Pku6O49fKNm7dOtplUytWRw=;
Received: from mail-yw1-f177.google.com ([209.85.128.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1p2IAs-0075Jt-VF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Dec 2022 20:34:51 +0000
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-3704852322fso130682707b3.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Dec 2022 12:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=;
 b=pV6KI/HZBQddAaryd4yKdtAZIjXHM+fQOQl8vls8oCF/Y0syljnC36hzxgQFzf3t1W
 ZEfFPue68nbSQYyN45g3vyc1tKTsDhhDmdhY4NZzbyws1OLLs/EBYBCLeHMjUZ7AqQkG
 bPHpYPqJ1AEZL4uauJNarKOb8Kjs0EiXHDayRbW+LvH0eVfIfd+Kt4GAhbisw/fJv8H5
 ye4ctWjmmYNQlCsceyNtIQIp7VQQPqFfnpnwbiE6A67xPTrxsvIZPcz5N+C3swPGuMEV
 zdL6BSwaRQTncT/q4vMGhtHQUJU0KVbms8kPcPSjUkErq0sjFtA3tGrr1dDn23Y/Q2aR
 UEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=;
 b=vTb4QQAz+HtYNOhGz3w2WEl1OacTzX9HmBH+a6rmxzt+Otbz1xATqYatnSoOCBXird
 zCt0885VRcXc36LM2YRrTPswW7Sf+aXHITJlkY0ky45GoBTqEeKeiX0pmxYOqswoFsuD
 sefR1FTYAWaG4xEjhZwoqHtU5VP7IcTjM+ZYPPO6JPw8ytNCH2V2WVkwZqPJplL2dNKk
 /9pHXFhw7ibgQeNuKZrCbejhz+GgfVw/a56wxECMbPV2zcUP9fl8pOGQA0g4AFa4hkYT
 Dd9v0GnGY5VTqR5JyP5ju/L2yyZeqYMpPNBoID/RJC2M3dU5CbX5+CdN5/OJuRxXXRcH
 CXlA==
X-Gm-Message-State: ANoB5pn1CD16RGAv7Vux5MWzvrR2NftwTtU9MyW3gtYlSz/zblgKpIXh
 nGzsk5XXeW6X2cdYrjXqUK8oKs88X8gxgTuRpww=
X-Google-Smtp-Source: AA0mqf6gVcUjGEuTNRozrYnWxY5uXjxRLCGPLpX8tEkUr/ot069nsH0uaNB29RtGgsmUEgc5iySKcYLMmK606QxvYxY=
X-Received: by 2002:a81:4905:0:b0:3a8:fad9:13c0 with SMTP id
 w5-20020a814905000000b003a8fad913c0mr60110141ywa.23.1670272485151; Mon, 05
 Dec 2022 12:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org>
 <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
 <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
In-Reply-To: <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Mon, 5 Dec 2022 12:34:33 -0800
Message-ID: <CAOzc2pzp0JEanJTgzSrRt3ziRCrR6rGCjpwJvAD8uCqsHqXnHg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1p2IAs-0075Jt-VF
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert
 f2fs_write_cache_pages() to use filemap_get_folios_tag()
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 22, 2022 at 6:26 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 1:38 PM Vishal Moola <vishal.moola@gmail.com> wrote:
> >
> > On Sun, Nov 13, 2022 at 11:02 PM Chao Yu <chao@kernel.org> wrote:
> > >
> > > On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> > > > Converted the function to use a folio_batch instead of pagevec. This is in
> > > > preparation for the removal of find_get_pages_range_tag().
> > > >
> > > > Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> > > > of pagevec. This does NOT support large folios. The function currently
> > >
> > > Vishal,
> > >
> > > It looks this patch tries to revert Fengnan's change:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
> > >
> > > How about doing some tests to evaluate its performance effect?
> >
> > Yeah I'll play around with it to see how much of a difference it makes.
>
> I did some testing. Looks like reverting Fengnan's change allows for
> occasional, but significant, spikes in write latency. I'll work on a variation
> of the patch that maintains the use of F2FS_ONSTACK_PAGES and send
> that in the next version of the patch series. Thanks for pointing that out!

Following Matthew's comment, I'm thinking we should go with this patch
as is. The numbers between both variations did not have substantial
differences with regard to latency.

While the new variant would maintain the use of F2FS_ONSTACK_PAGES,
the code becomes messier and would end up limiting the number of
folios written back once large folio support is added. This means it would
have to be converted down to this version later anyways.

Does leaving this patch as is sound good to you?

For reference, here's what the version continuing to use a page
array of size F2FS_ONSTACK_PAGES would change:

+               nr_pages = 0;
+again:
+               nr_folios = filemap_get_folios_tag(mapping, &index, end,
+                               tag, &fbatch);
+               if (nr_folios == 0) {
+                       if (nr_pages)
+                               goto write;
+                               goto write;
                        break;
+               }

+               for (i = 0; i < nr_folios; i++) {
+                       struct folio* folio = fbatch.folios[i];
+
+                       idx = 0;
+                       p = folio_nr_pages(folio);
+add_more:
+                       pages[nr_pages] = folio_page(folio,idx);
+                       folio_ref_inc(folio);
+                       if (++nr_pages == F2FS_ONSTACK_PAGES) {
+                               index = folio->index + idx + 1;
+                               folio_batch_release(&fbatch);
+                               goto write;
+                       }
+                       if (++idx < p)
+                               goto add_more;
+               }
+               folio_batch_release(&fbatch);
+               goto again;
+write:

> How do the remaining f2fs patches in the series look to you?
> Patch 16/23 f2fs_sync_meta_pages() in particular seems like it may
> be prone to problems. If there are any changes that need to be made to
> it I can include those in the next version as well.

Thanks for reviewing the patches so far. I wanted to follow up on asking
for review of the last couple of patches.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
