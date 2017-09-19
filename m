From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Tue, 19 Sep 2017 08:55:47 -0700
Message-ID: <20170919155547.GA40124@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
 <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915042137.GX5426@ZenIV.linux.org.uk>
 <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915221238.js6elr5jmj4mgt67@thunk.org>
 <20170915232911.GA44998@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915234343.GA5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915234343.GA5426@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/16, Al Viro wrote:
> On Fri, Sep 15, 2017 at 04:29:11PM -0700, Jaegeuk Kim wrote:
> 
> > The mntput() in delayed_fput() is the last function call. So before that moment,
> > sys_umount() may see mnt_get_count() as 2, so it avoids EBUSY condition. I'm not
> > sure why it check over 2 tho.
> 
> Because it has just grabbed a reference itself, in addition to the one that keeps
> the damn thing alive (due to being mounted).  So it bloody well should have
> triggered -EBUSY, if they refer to the same vfsmount.

I've tracked another view in terms of mnt_get_count() and sb->s_active based on
namespaces, and could get the below scenario for instance.

Term: namespace(mnt_get_count())

1. create_new_namespaces() creates ns1 and ns2,

  /data(1)    ns1(1)    ns2(1)
    |          |          |
     ---------------------
               |
        sb->s_active = 3

2. after binder_proc_clear_zombies() for ns2 and ns1 triggers
  - delayed_fput()
    - delayed_mntput_work(ns2)

  /data(1)    ns1(1)
    |          |
     ----------
          |
    sb->s_active = 2

3. umount() for /data is successed.

  ns1(1)
    |
 sb->s_active = 1

4. device_shutdown() by init

5.  - delayed_mntput_work(ns1)
     - put_super(), since sb->s_active = 0
       - -EIO

Please let me know, if I'm missing something.

Thanks,
