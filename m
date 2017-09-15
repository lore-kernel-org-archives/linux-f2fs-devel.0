From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for
 umount completion
Date: Fri, 15 Sep 2017 03:06:07 +0100
Message-ID: <20170915020607.GW5426@ZenIV.linux.org.uk>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170913230426.GN5426@ZenIV.linux.org.uk>
 <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
 <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <viro@ftp.linux.org.uk>)
 id 1dsg1J-00036l-6r
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Sep 2017 02:06:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dsg1H-0006Ev-TF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Sep 2017 02:06:17 +0000
Content-Disposition: inline
In-Reply-To: <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Sep 14, 2017 at 05:19:39PM -0700, Jaegeuk Kim wrote:
> Instead, I put more traces in the reboot procedure, and got a clue to suspect
> the below flow.
> 
> delayed_fput()                 init
>                                - umount
>  - mntput()
>  - mntput_no_expire()            - mntput_no_expire()
>                                  - mnt_add_count(-1);
>                                  - mnt_get_count() return;
>                                  - return 0;
>  - mnt_add_count(-1);
>  - delayed_mntput_work
>                                - device_shutdown
>  - ext4_put_super()
>  - EIO
> 
> Does this make any sense?

Which filesystem it is?  With root I would've expected remount ro done
by sys_umount(); with anything else...  How has it managed to avoid
-EBUSY?  If it was umount -l (IOW, MNT_DETACH), I can see that happening,
but...  How would flushing prevent the scenario when the same opened
file had remained open until after the umount(2) return?

In other words, where has that fput() come from and how had it managed
to get past the umount(2)?

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
