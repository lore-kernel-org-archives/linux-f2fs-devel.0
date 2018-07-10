From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Replace strncpy with memcpy
Date: Tue, 10 Jul 2018 08:58:25 -0700
Message-ID: <20180710155825.GB10635@roeck-us.net>
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
 <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
 <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
 <ecb4f083-1d61-d882-c85c-53cb33fa793e@huawei.com>
 <CAD14+f0eRF9y-QNMXwXEymQGOZ_D22sbdqwAuXg5Cv=SXryApQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD14+f0eRF9y-QNMXwXEymQGOZ_D22sbdqwAuXg5Cv=SXryApQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jul 10, 2018 at 11:35:08PM +0900, Ju Hyung Park wrote:
> I must be missing something here.
> 
> Shouldn't the third argument be 'strlen(name) + 1', if we were to use
> memcpy()?
> strcpy()/strncpy() appends null terminator to the destination whereas
> memcpy() doesn't.
> 

strncpy() does not append a null character if the passed length is smaller
than or equal to the string length. strncpy(dest, "x", strlen("x")) copies
exactly one character. The code as written specifically does _not_ append
a terminator to the end of the copied string.

Guenter

> Thanks,
> 
> On Mon, Jul 2, 2018 at 11:57 AM, Chao Yu <yuchao0@huawei.com> wrote:
> 
> > On 2018/7/2 10:16, Guenter Roeck wrote:
> > > On 07/01/2018 06:53 PM, Chao Yu wrote:
> > >> On 2018/7/2 4:57, Guenter Roeck wrote:
> > >>> gcc 8.1.0 complains:
> > >>>
> > >>> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
> > >>> fs/f2fs/namei.c:257:3: warning:
> > >>>     'strncpy' output truncated before terminating nul copying
> > >>>     as many bytes from a string as its length
> > >>> fs/f2fs/namei.c:249:3: warning:
> > >>>     'strncpy' output truncated before terminating nul copying
> > >>>     as many bytes from a string as its length
> > >>>
> > >>> Using strncpy() is indeed less than perfect since the length of data to
> > >>> be copied has already been determined with strlen(). Replace strncpy()
> > >>> with memcpy() to address the warning and optimize the code a little.
> > >>>
> > >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >>> ---
> > >>>   fs/f2fs/namei.c | 4 ++--
> > >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > >>> index 231b7f3ea7d3..e75607544f7c 100644
> > >>> --- a/fs/f2fs/namei.c
> > >>> +++ b/fs/f2fs/namei.c
> > >>> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct
> > f2fs_sb_info *sbi, const char *name,
> > >>>             return -EINVAL;
> > >>>
> > >>>     if (hot) {
> > >>> -           strncpy(extlist[count], name, strlen(name));
> > >>> +           memcpy(extlist[count], name, strlen(name));
> > >>
> > >> How about replacing with strcpy(extlist[count], name)? Because name
> > length has
> > >> already been checked before f2fs_update_extension_list, it should be
> > valid, and
> > >> will not cause overflow during copying.
> > >>
> > >
> > > Your call; feel free to submit an alternative. Since it is different
> > files, static
> > > analysis might not know and complain, though. You might want to make
> > sure that this
> > > doesn't happen, and also add a comment explaining the reason for using
> > strcpy().
> >
> > Yeah, that could be changed in another patch, but it will be trivial.
> > Anyway, to
> > fix this gcc complaint, this patch looks good to me, thanks for the patch.
> > :)
> >
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > > Guenter
> > >
> > >
> >
> >
> > ------------------------------------------------------------
> > ------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
