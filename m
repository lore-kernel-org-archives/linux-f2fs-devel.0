From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: Security fixes for 4.4 - f2fs
Date: Tue, 05 Feb 2019 13:59:22 +0000
Message-ID: <1549375162.2925.5.camel@codethink.co.uk>
References: <1547753327.3229.115.camel@codethink.co.uk>
         <f84bbaf0-d5d1-4e3f-bde7-e73e95748e2f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <f84bbaf0-d5d1-4e3f-bde7-e73e95748e2f@suse.cz>
Sender: stable-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, 2019-01-29 at 13:41 +0100, Jiri Slaby wrote:
> On 17. 01. 19, 20:28, Ben Hutchings wrote:
> > I've backported fixes for several security issues involving filesystem
> > validation in f2fs.  All of these are already fixed in the later stable
> > branches.
> > 
> > I tested with the reproducers where available.  I also checked for
> > regressions with xfstests and didn't find any (but many tests fail with
> > or without these changes).
> 
> Hi,
> 
> I am thinking why in this patch:
> > From ec2d979dc3888b6de795344157bb6fe73bbe8e44 Mon Sep 17 00:00:00 2001
> > From: Chao Yu <yuchao0@huawei.com>
> > Date: Wed, 22 Mar 2017 14:45:05 +0800
> > Subject: [PATCH 18/36] f2fs: fix race condition in between free nid
> >  allocator/initializer
> > 
> > commit 30a61ddf8117c26ac5b295e1233eaa9629a94ca3 upstream.
> > 
> 
> you do:
> 
> > +       err = 0;
> >         list_add_tail(&i->list, &nm_i->free_nid_list);
> >         nm_i->fcnt++;
> > +err_out:
> >         spin_unlock(&nm_i->free_nid_list_lock);
> >         radix_tree_preload_end();
> > -       return 1;
> > +err:
> > +       if (err)
> > +               kmem_cache_free(free_nid_slab, i);
> > +       return !err;
> 
> "!err"? Should it be "err < 0 ? err : 1" instead?

This function previously returned -1 (low memory), 0 (error), or 1
(success).  This fix should not and does not change that.

(In the upstream code, this function returns true or false, and again
the upstream fix did not change that.)

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
