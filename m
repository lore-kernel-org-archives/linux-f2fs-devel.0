From: Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for
 umount completion
Date: Sat, 16 Sep 2017 10:11:26 +0300
Message-ID: <CAOQ4uxhke96rpaBRRmoQu2LsgMMHAwT2SfYy5kn1YPRNZbJfDg@mail.gmail.com>
References: <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
 <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915042137.GX5426@ZenIV.linux.org.uk>
 <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915221238.js6elr5jmj4mgt67@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <amir73il@gmail.com>) id 1dt7GH-0000ov-EF
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Sep 2017 07:11:33 +0000
Received: from mail-yw0-f196.google.com ([209.85.161.196])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dt7GG-0007Xi-Mr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Sep 2017 07:11:33 +0000
Received: by mail-yw0-f196.google.com with SMTP id v72so2813261ywa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 16 Sep 2017 00:11:32 -0700 (PDT)
In-Reply-To: <20170915221238.js6elr5jmj4mgt67@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 16, 2017 at 1:12 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, Sep 15, 2017 at 11:44:33AM -0700, Jaegeuk Kim wrote:
>>
>> So, I digged it in more detail, and found, in drivers/android/binder.c [1],
>> - binder_ioctl()
>>  - create a kernel thread
>>  - zombie_cleanup_check()
>>   - binder_defer_work()
>>     - queue_work(..., &binder_deferred_work);
>>
>> - binder_deferred_func()
>>  - binder_clear_zombies()
>>   - binder_proc_clear_zombies()
>>    - put_files_struct()
>>     - close_files()
>>      - filp_close()
>>       - fput()
>>
>> It seems binder holds some proc files.
>
> If binder was holding some files open, then umount should have failed
> with EBUSY, no?
>
> Does Android use mount namespaces at all?
>

Extensively.
Every user (i.e. from multi user) has its own mount ns with private /data
Every app has its own mount ns, with /sdcard mounted to one of 3 FUSE
sdcard mounts depending of app storage permission (none, rdonly, rdwr).

Amir.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
