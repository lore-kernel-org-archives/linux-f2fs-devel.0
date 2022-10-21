Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05557C4167D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Oct 2022 08:16:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olnCy-0006Yx-8H;
	Fri, 21 Oct 2022 08:16:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1olnCm-0006Yl-Ee
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 08:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bv+xn0CYyTQsdUJdG42v0pWcxCKWbW+L5mfPqjTqsn4=; b=lPSshVyPKQEdgqJk9yw2AI10s5
 ldNxtiwKcdQEO6/7VchR7+M8b3dibUv2f7aNzpGNNlEXIWb5RGPyjER7BFs9MD0Ntyv3oLeuTPhE2
 Yeas2wlJbTqfkRd9j3uzLh8PLG7JCaQX58WsUD3fNzWY5wjl3JJw3rQzhEv9+XW+GwKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Bv+xn0CYyTQsdUJdG42v0pWcxCKWbW+L5mfPqjTqsn4=; b=W3QPXW2sKbCtNKhvaMddY72dzt
 vh3tAglSSKLFQNumlzteWFzEDGiX8RUSw+J8O8vIaLgEFNrI2y4yXKRzR3IXv7HTKITievtPZajIy
 DEpvNxARnlR9xHmOEOOb9RmZaKrx7bAl+Fmfrsx/QBmFaoHx6xcDjcpKYx1h3aQAY14o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olnCk-0000F4-VZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 08:16:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6D8AF61DF6;
 Fri, 21 Oct 2022 08:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F7C433D7;
 Fri, 21 Oct 2022 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1666340188;
 bh=nDtywa6mieJPfGn7a73ycNgAHcz816CMD4ioaA/ZgqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lO82TxFXbxQ1cn2DOqHCEKyNscPmKusZYKwJGtS1W9wHd/+uOdMexrwxM5m/eoZGP
 ixuN1pMyIVVKVRufxw1DnKqd7DCICC9i7tVNcPFmRr0aUFAthWwsrDgNS/LTSDl6lj
 lH2fmm/4fi6QX2qSDaq/NHngB7BNdQ/cZRRC7bts=
Date: Fri, 21 Oct 2022 10:16:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <Y1JVWsLs0EQ3dtxM@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
 <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
 <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
X-Headers-End: 1olnCk-0000F4-VZ
Subject: Re: [f2fs-dev] [PATCH 01/11] kset: fix documentation for
 kset_register()
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com,
 joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, richard@nod.at,
 mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org,
 Luben Tuikov <luben.tuikov@amd.com>, hsiangkao@linux.alibaba.com,
 somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 alexander.deucher@amd.com, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 21, 2022 at 04:05:18PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/21 13:34, Luben Tuikov wrote:
> > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > kset_register() is currently used in some places without calling
> > > kset_put() in error path, because the callers think it should be
> > > kset internal thing to do, but the driver core can not know what
> > > caller doing with that memory at times. The memory could be freed
> > > both in kset_put() and error path of caller, if it is called in
> > > kset_register().
> > > 
> > > So make the function documentation more explicit about calling
> > > kset_put() in the error path of caller.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   lib/kobject.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index a0b2dbfcfa23..6da04353d974 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
> > >   /**
> > >    * kset_register() - Initialize and add a kset.
> > >    * @k: kset.
> > > + *
> > > + * If this function returns an error, kset_put() must be called to
> > > + * properly clean up the memory associated with the object.
> > >    */
> > And I'd continue the sentence, with " ... with the object,
> > for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
> > was called before calling kset_register()."
> kobject_cleanup() not only frees name, but aslo calls ->release() to free
> another resources.

Yes, but it's the kobject of the kset, which does need to have it's name
cleaned up, but that kobject should NOT be freeing any larger structures
that the kset might be embedded in, right?

> > This makes it clear what we want to make sure is freed, in case of an early error
> > from kset_register().
> 
> How about like this:
> 
> If this function returns an error, kset_put() must be called to clean up the name of
> kset object and other memory associated with the object.

Again, I think we can fix this up to not be needed.

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
