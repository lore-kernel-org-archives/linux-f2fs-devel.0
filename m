Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E133C433EA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:17:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAAE206E3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PJIdOwsd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HpOQzY7b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awreHD28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAAE206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jylPJ-000470-Gf; Fri, 24 Jul 2020 00:17:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drinkcat@chromium.org>) id 1jylPF-00046o-91
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 00:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tn6bqYg/1KWkV4kpAzCYFhcP+XCPRuDgdoeZet33vWk=; b=PJIdOwsdcavhGJpzF/C0TaC5fE
 KXQrfYgN5fpQWb4voloTR6xjnvZcUBtUi6YaMMBtS7ANu+rLNl5Ims+VqspTHGFh2FsfNfhKnS4fj
 eP/BKjgjR83qlXY2/LYJC+yLn3njy9BBeeT1HSKK7pQIeSae6meEv4Sr5brgqa7wllQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Tn6bqYg/1KWkV4kpAzCYFhcP+XCPRuDgdoeZet33vWk=; b=HpOQzY7b/MfJom4BIXGtHYK3Mu
 YLvS2OamofKWvhaJ7mOYoQXVsT6izdawyQFF0nROBTq0oGkmlZXSfMZPhz7+hbidukq9BqKj5Aqhv
 P6elbX7pQal41wkP7EW/M4mlpjWEb5CASDDAN431eRiUdOiEHCm0RWcbUq5DCCXybnE0=;
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jylPC-000t9t-Pf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 00:17:44 +0000
Received: by mail-ua1-f68.google.com with SMTP id r63so2408375uar.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2020 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tn6bqYg/1KWkV4kpAzCYFhcP+XCPRuDgdoeZet33vWk=;
 b=awreHD28nDVNZexMGVyopatjZJnZVe7HOWZqVLh+RCrrko33Dtr7aUGgwOkz5TkDTZ
 0yYGVwi8WX8RUoZPeer0O6R6Mkxv2fwqIKd57tgnZhCiaJXkJVcV2SPbhNZ3XCGWvsmS
 wfHBen5QSZrel1hvkK/0sXZYsKhLRDS4KyFac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tn6bqYg/1KWkV4kpAzCYFhcP+XCPRuDgdoeZet33vWk=;
 b=iX2JJAnYkIaVc2rlQCc13wDOVD/6fYR1fDccrL8ce/Y00Sa9AzWXaDWgn7CmGJ32PT
 kte3ylMlp0I0T5Axd2L3hXpD2yeC6GVpNuKfeErtUq0YhG3+buVvSfp/jyUKHdghOp04
 2bRzVKSo2L73C8vLChJLuQmdoJ1XnNJGBkGGmpWxVFp46bC/V9rQ8xbipvZoENrN2Pbl
 xDrluj1N3PuOVPTMAuPp3MX+PQD/KH8QWf1bhkyXu+eWXZZ9ssAzOfFWp01YzESmkKWe
 PMAvx0I5HmbtvoAg2+CuyH0bsoCD6gJIJKrGUsYR8zqk+Y/3M7uZ1+HXYYhqQkCFuUpc
 CA5A==
X-Gm-Message-State: AOAM532qjmiEzYjOEPCl5TlBsSPPAnDff15aDe7hSJOMf6ZWP4FC/1QH
 RE3GtF/s4mIyVYMY9aNQm/jtplM5brbWdC9Thhi0Cg==
X-Google-Smtp-Source: ABdhPJyap0e7CTwf8HrhrJhPhF9DOR7AKPD9OIoxL1bXe7v3Dk4cmLWDUcc1+/hhsto3hTn53fbsk/M7qmHWyPm46q8=
X-Received: by 2002:a9f:22c4:: with SMTP id 62mr6134025uan.135.1595549856863; 
 Thu, 23 Jul 2020 17:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200627070307.516803-1-drinkcat@chromium.org>
 <20200627070307.516803-2-drinkcat@chromium.org> <878sfanzft.fsf@kernel.org>
In-Reply-To: <878sfanzft.fsf@kernel.org>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 24 Jul 2020 08:17:25 +0800
Message-ID: <CANMq1KDugXcmvrGOJzcvWvbzScPDsQVuJ4gSDXTJan+FY1H3Ew@mail.gmail.com>
To: Felipe Balbi <balbi@kernel.org>
X-Headers-End: 1jylPC-000t9t-Pf
Subject: Re: [f2fs-dev] [PATCH 1/4] usb: cdns3: gadget: Replace trace_printk
 by dev_dbg
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
Cc: Peter Chen <peter.chen@nxp.com>,
 "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
 Rafael Aquini <aquini@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Howells <dhowells@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Will Deacon <will@kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jayshri Pawar <jpawar@cadence.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Andy Gross <agross@kernel.org>,
 Tomas Winkler <tomas.winkler@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Daniel Vetter <daniel@ffwll.ch>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Roger Quadros <rogerq@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-usb@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Divya Indi <divya.indi@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 23, 2020 at 9:17 PM Felipe Balbi <balbi@kernel.org> wrote:
>
> Nicolas Boichat <drinkcat@chromium.org> writes:
>
> > trace_printk should not be used in production code, replace it
> > call with dev_dbg.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > ---
> >
> > Unclear why a trace_printk was used in the first place, it's
> > possible that some rate-limiting is necessary here.
> >
> >  drivers/usb/cdns3/gadget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> > index 5e24c2e57c0d8c8..c303ab7c62d1651 100644
> > --- a/drivers/usb/cdns3/gadget.c
> > +++ b/drivers/usb/cdns3/gadget.c
> > @@ -421,7 +421,7 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
> >               if ((priv_req->flags & REQUEST_INTERNAL) ||
> >                   (priv_ep->flags & EP_TDLCHK_EN) ||
> >                       priv_ep->use_streams) {
> > -                     trace_printk("Blocking external request\n");
> > +                     dev_dbg(priv_dev->dev, "Blocking external request\n");
>
> Instead, I would suggest adding a proper trace event here; one that
> includes "priv_ep->flags" in the output.

The patch was already merged by Greg
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/cdns3/gadget.c?id=b3a5ce874c2619c9b8a6c5bbcfefdb95e0227600),
but feel free to do that as a follow-up CL.

Looks like Peter -- the main author, is ok with dev_dbg (also,
apologies for missing the R-b tag when I sent a v2 -- which is the one
that was merged by Greg).

Thanks,

>
> --
> balbi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
